﻿using System;
using System.Diagnostics;
using static Camera.DllCall;

namespace Camera
{
    class Program
    {
        static IntPtr Handle;
        static IntPtr MainWindowHandle;
        static IntPtr GameDllOffSet;

        //camera.exe distance X Y
        static int Main(string[] args)
        {
            if (args.Length != 3)
                return 1; // not enough args

            foreach (var arg in args)
            {
                float number;
                bool success = float.TryParse(arg, out number);
                if (!success)
                    return 2; // invaild type, has to be number
            }

            if (float.Parse(args[0]) < 1 || float.Parse(args[0]) > 6000)
                return 3; // invaild value range

            //get wc3 process handle and game.dll offset
            Process[] processlist = Process.GetProcesses();

            foreach (Process theprocess in processlist)
            {
                if (theprocess.ProcessName == "Warcraft III")
                {
                    Handle = theprocess.Handle;
                    MainWindowHandle = theprocess.MainWindowHandle;
                    foreach (ProcessModule module in theprocess.Modules)
                    {
                        if (module.ModuleName.ToLower() == "game.dll")
                        {
                            GameDllOffSet = module.BaseAddress;
                        }
                    }
                }
            }

            if (GameDllOffSet == null)
                return 4; //game.dll not found

            //apply camera settings
            CameraDistance(float.Parse(args[0]));
            CameraAngleX(float.Parse(args[1]));
            CameraAngleY(float.Parse(args[2]));
            CameraInit();
            return 0;
        }
        public static void CameraInit()
        {
            PostMessage(MainWindowHandle, 0x100, 27, 0);
            PostMessage(MainWindowHandle, 0x101, 27, 0);
            PostMessage(MainWindowHandle, 0x100, 46, 0);
            PostMessage(MainWindowHandle, 0x101, 46, 0);
        }
        public static void CameraDistance(float value)
        {
            if (GameDllOffSet == IntPtr.Zero) return;
            Patch(GameDllOffSet + 0xA8F300, BitConverter.GetBytes(value));
        }
        public static void CameraAngleX(float value)
        {
            if (GameDllOffSet == IntPtr.Zero) return;
            Patch(GameDllOffSet + 0xA8F2D0, BitConverter.GetBytes(value));
        }
        public static void CameraAngleY(float value)
        {

            if (GameDllOffSet == IntPtr.Zero) return;
            Patch(GameDllOffSet + 0xA8F2F0, BitConverter.GetBytes(value));
        }
        internal static void Patch(IntPtr offset, params byte[] buffer) => Patch(offset, buffer.Length, buffer);
        internal static void Patch(IntPtr offset, int size, params byte[] buffer)
        {
            VirtualProtectEx(Handle, offset, size, 0x40, out uint lpflOldProtect);
            WriteProcessMemory(Handle, offset, buffer, size, out _);
            VirtualProtectEx(Handle, offset, size, lpflOldProtect, out _);
        }
        internal static byte[] Bring(IntPtr Offset, int size)
        {
            byte[] lpBuffer = new byte[size];
            VirtualProtectEx(Handle, Offset, size, 0x40, out uint lpflOldProtect);
            bool ret = ReadProcessMemory(Handle, Offset, lpBuffer, size, out _);
            VirtualProtectEx(Handle, Offset, size, lpflOldProtect, out _);
            return ret ? lpBuffer : null;
        }
    }
}
