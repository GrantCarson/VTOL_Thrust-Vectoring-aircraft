using System;

using DCMAPI;

namespace DCMDriver
	{
	class Program
		{
		static void Main( string[] args )
			{

			DCM	E = new DCM(new Vector (0.0F, 0.0F, 0.0F));
			E.Print("E - base coordinates");

			for (int i = 0; i < 1; i++)
				{
                DCM	R = new DCM(new Vector(0.05F, 0.06F, 0.07F));
                R.Print("Small rotation: Yaw=0.05, Pitch=0.06, Roll=0.07");

                Console.WriteLine("\r\nStep: {0,4}\tEPitch={1,7:F4} rad\tERoll={2,7:F4} rad rad\tEYaw={3,7:F4} rad", i, E.Pitch, E.Roll, E.Yaw);
                Console.WriteLine("\r\nStep: {0,4}\tEPitch={1,7:F4} rad\tERoll={2,7:F4} rad rad\tEYaw={3,7:F4} rad", i, R.Pitch, R.Roll, R.Yaw);

                E = E.Transform(R);
				E = E.Normalize();
				E.Print("E = E x R");

                //Console.WriteLine("R.ToString: ", R.ToString);

                Console.WriteLine("\r\nStep: {0,4}\tEPitch={1,7:F4} rad\tERoll={2,7:F4} rad rad\tEYaw={3,7:F4} rad", i, E.Pitch, E.Roll, E.Yaw);
				Console.WriteLine("\r\nStep: {0,4}\tEPitch={1,7:F4} deg\tERoll={2,7:F4} deg", i, E.PitchDeg, E.RollDeg);
                

                /*
                R = R.Transform(E);
                R = R.Normalize();
                R.Print("R = R x E");

                Console.WriteLine("\r\nStep: {0,4}\tRPitch={1,7:F4} rad\tRRoll={2,7:F4} rad", i, R.Pitch, R.Roll);
                Console.WriteLine("\r\nStep: {0,4}\tRPitch={1,7:F4} deg\tRRoll={2,7:F4} deg", i, R.PitchDeg, R.RollDeg);
                */
            }
			//Console.ReadLine();
            Console.ReadLine();

        }
		}
	}
