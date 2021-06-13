using System;
using System.IO;
using System.Text;
using SBucket;
using VoxelBuilder.Serialisation;

namespace VoxelBuilder
{

    public struct Voxel
    {
        public static string ByteArrayToString(byte[] ba)
        {
            StringBuilder hex = new StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:x2}", b);
            return hex.ToString();
        }
        public int X { get; set; }
        public int Y { get; set; }
        public int Z { get; set; }

        public bool IsValidColor()
        {
            if (Color == null)
            {
                return false;
            }

            if (Color.Length != 3)
            {
                return false;
            }
            return true;
        }
        public byte GetRed()
        {
            if (!IsValidColor())
            {
                return 0;
            }
            return Color[0];
        }
        public byte GetGreen()
        {
            if (!IsValidColor())
            {
                return 0;
            }
            return Color[1];
        }
        public byte GetBlue()
        {
            if (!IsValidColor())
            {
                return 0;
            }
            return Color[2];
        }
        public byte[] Color { get; set; }
        public override string ToString()
        {
            if (Color == null || Color.Length == 0)
            {
                return null;
            }
            return $"{X} {Y} {Z} {GetColorsAsHex()}";
        }
        public string GetColorsAsHex()
        {
            return ByteArrayToString(Color);
        }
    }
    public class VoxelBuilder
    {

        public static void RunVoxelBuilderTests()
        {
            Logger.header("Running voxel builder test");
            Logger.info("Loading voxel from string");

            var inFile = Path.Combine(Directory.GetCurrentDirectory(), "code/VoxelBuilder/models/shovel.vox");
            var builder = VoxelCore.DeserialiseFromFile(inFile);
            Console.WriteLine(builder);

            Logger.info("Saving same voxel to string");

            var outFile = Path.Combine(Directory.GetCurrentDirectory(), "code/VoxelBuilder/models/shovel3.vox");
            VoxelCore.SaveToFile(builder, outFile);

            builder = VoxelCore.DeserialiseFromFile(outFile);
        }

        public int Width { get; set; }
        public int Height { get; set; }
        public int Depth { get; set; }

        public Voxel[,,] Data { get; set; }
        public VoxelBuilder(int width, int height, int depth, int type, int d)
        {
            this.Resize(width, height, depth);
        }

        public void Resize(int newWidth, int newHeight, int newDepth)
        {
            var newData = new Voxel[newWidth, newHeight, newDepth];
            if (Data != null)
            {
                for (int x = 0; x < Width; x++)
                {
                    for (int y = 0; y < Height; y++)
                    {
                        for (int z = 0; z < Depth; z++)
                        {
                            if (IsInBounds(x, y, z))
                            {
                                try
                                {
                                    newData[x, y, z] = Data[x, y, z];
                                }
                                catch (Exception)
                                {

                                }
                            }
                        }
                    }
                }
            }

            Height = newHeight;
            Width = newWidth;
            Depth = newDepth;
            Data = newData;
        }

        public bool IsInBounds(int x, int y, int z)
        {
            if (x < 0 || x > Width - 1)
            {
                return false;
            }
            if (y < 0 || y > Height - 1)
            {
                return false;
            }
            if (z < 0 || z > Depth - 1)
            {
                return false;
            }

            return true;
        }


        public Voxel? Get(int x, int y, int z)
        {
            if (IsInBounds(x, y, z))
            {
                return Data?[x, y, z];
            }
            return null;
        }

        public bool Set(int x, int y, int z, byte[] colours, bool autoResize = true)
        {
            var voxel = new Voxel();
            voxel.X = x;
            voxel.Y = y;
            voxel.Z = z;
            voxel.Color = colours;
            return Set(voxel, autoResize);
        }

        public bool Set(Voxel v, bool autoResize = true)
        {
            if (!IsInBounds(v.X, v.Y, v.Z))
            {
                if (!autoResize)
                {
                    return false;
                }
                Resize(v.X, v.Y, v.Z);
            }
            Data[v.X, v.Y, v.Z] = v;
            return true;
        }

        public override string ToString()
        {
            return VoxelCore.Serialise(this);
        }
    }
}
