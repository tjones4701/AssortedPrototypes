using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace VoxelBuilder.Serialisation.Text
{

    public class GoxelSerialisation
    {

        public static byte[] StringToByteArrayFastest(string hex)
        {
            if (hex.Length % 2 == 1)
                throw new Exception("The binary key cannot have an odd number of digits");

            byte[] arr = new byte[hex.Length >> 1];

            for (int i = 0; i < hex.Length >> 1; ++i)
            {
                arr[i] = (byte)((GetHexVal(hex[i << 1]) << 4) + (GetHexVal(hex[(i << 1) + 1])));
            }

            return arr;
        }

        public static int GetHexVal(char hex)
        {
            int val = (int)hex;
            //For uppercase A-F letters:
            //return val - (val < 58 ? 48 : 55);
            //For lowercase a-f letters:
            //return val - (val < 58 ? 48 : 87);
            //Or the two combined, but a bit slower:
            return val - (val < 58 ? 48 : (val < 97 ? 55 : 87));
        }
        public static VoxelBuilder Deserialise(string data)
        {
            var builder = new VoxelBuilder(0, 0, 0, 0, 0);
            if (data != null)
            {
                int maxHeight = 0;
                int maxWidth = 0;
                int maxDepth = 0;
                int minHeight = 0;
                int minWidth = 0;
                int minDepth = 0;

                var voxels = new List<Voxel>();

                string[] lines = data.Split(
                    new[] { "\r\n", "\r", "\n" },
                    StringSplitOptions.None
                );
                var startLoading = false;
                foreach (var line in lines)
                {
                    if (line.Trim() == "# X Y Z RRGGBB")
                    {
                        startLoading = true;
                    }
                    else if (startLoading == true)
                    {
                        string[] parts = line.Trim().Split(" ", StringSplitOptions.None);
                        try
                        {
                            int x = Int32.Parse(parts[0]);
                            int y = Int32.Parse(parts[1]);
                            int z = Int32.Parse(parts[2]);
                            string colors = parts[3];
                            var voxel = new Voxel();
                            voxel.X = x;
                            voxel.Y = y;
                            voxel.Z = z;
                            voxel.Color = StringToByteArrayFastest(colors);
                            Console.WriteLine(voxel);
                            voxels.Add(voxel);


                            if (x > maxWidth)
                            {
                                maxWidth = x;
                            }
                            if (x < minWidth)
                            {
                                minWidth = x;
                            }

                            if (y > maxHeight)
                            {
                                maxHeight = y;
                            }

                            if (y < minHeight)
                            {
                                minHeight = y;
                            }

                            if (z > maxDepth)
                            {
                                maxDepth = z;
                            }
                            if (z < minDepth)
                            {
                                minDepth = z;
                            }
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                }

                if (maxWidth < 0)
                {
                    maxWidth = 0;
                    minWidth = minWidth - maxWidth;
                }
                if (maxHeight < 0)
                {
                    maxHeight = 0;
                    minHeight = minHeight - (0 - maxHeight);
                }
                if (maxDepth < 0)
                {
                    maxDepth = 0;
                    minDepth = minDepth - maxDepth;
                }


                int xDifference = 0 - minWidth;
                int yDifference = 0 - minHeight;
                int zDifference = 0 - minDepth;

                builder.Resize((maxWidth - minWidth) + 1, (maxHeight - minHeight) + 1, (maxDepth - maxDepth) + 1);

                for (int i = 0; i < voxels.Count; i++)
                {
                    var voxel = voxels[i];
                    voxel.X = voxel.X + xDifference;
                    voxel.Y = voxel.Y + yDifference;
                    voxel.Z = voxel.Z + zDifference;
                    var added = builder.Set(voxel, false);
                    if (!added)
                    {
                        Console.WriteLine($"[{voxel}] Not in bounds");
                    }
                }

            }
            return builder;
        }

        public static string Serialise(VoxelBuilder builder)
        {
            var lines = "";
            lines = lines + "# Goxel 0.10.5\n";
            lines = lines + "# One line per voxel\n";
            lines = lines + "# X Y Z RRGGBB";

            for (int x = 0; x < builder.Width; x++)
            {
                for (int y = 0; y < builder.Height; y++)
                {
                    for (int z = 0; z < builder.Depth; z++)
                    {
                        var voxel = builder.Get(x, y, z);
                        try
                        {

                            if (voxel != null)
                            {
                                var line = voxel.ToString();
                                if ((line?.Length ?? 0) > 0)
                                {
                                    lines = lines + "\n" + line;
                                }
                            }
                        }
                        catch (Exception)
                        {
                            Console.WriteLine($"[{voxel}] Unable to serialise");
                        }
                    }
                }
            }

            return lines;
        }
    }

}
