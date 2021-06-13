using System;
using Voxels;
namespace VoxelBuilder.Serialisation
{

    public class VoxelCore
    {

        public static VoxelBuilder DeserialiseFromFile(string path)
        {
            var builder = new VoxelBuilder(0, 0, 0, 0, 0);
            var voxelData = Voxels.VoxelImport.Import(path);
            builder.Resize(voxelData.size.X, voxelData.size.Y, voxelData.size.Z);

            for (int x = 0; x < builder.Width; x++)
            {
                for (int y = 0; y < builder.Height; y++)
                {
                    for (int z = 0; z < builder.Depth; z++)
                    {
                        var voxel = voxelData[new XYZ(x, y, z)];
                        if (voxel.IsVisible)
                        {
                            var voxelColor = voxelData.ColorOf(voxel);
                            var color = new byte[] { voxelColor.R, voxelColor.G, voxelColor.B };
                            if (voxelColor.A > 0)
                            {
                                builder.Set(x, y, z, color, false);
                            }
                        }
                    }
                }
            }

            return builder;
        }

        public static void SaveToFile(VoxelBuilder builder, string path)
        {
            var size = new XYZ(builder.Width, builder.Height, builder.Depth);
            var voxelData = new VoxelData(size, null);

            for (int x = 0; x < builder.Width; x++)
            {
                for (int y = 0; y < builder.Height; y++)
                {
                    for (int z = 0; z < builder.Depth; z++)
                    {
                        var pos = new XYZ(x, y, z);
                        Voxel? MaybeNullVoxel = builder.Get(x, y, z);
                        Voxels.Color color = Voxels.Color.Transparent;
                        if (MaybeNullVoxel != null)
                        {
                            Voxel voxel = (Voxel)MaybeNullVoxel;
                            if (voxel.IsValidColor())
                            {
                                color = new Voxels.Color(voxel.GetRed(), voxel.GetGreen(), voxel.GetBlue());
                            }
                        }

                        voxelData[new XYZ(x, y, z)] = new Voxels.Voxel(color);

                    }
                }
            }

            MagicaVoxel.Write(path, voxelData);
        }


        public static VoxelBuilder Deserialise(string data)
        {
            var builder = new VoxelBuilder(0, 0, 0, 0, 0);

            return builder;
        }

        public static string Serialise(VoxelBuilder builder)
        {
            var lines = "";
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
