using System;
using System.Runtime.InteropServices;

namespace Camera
{
    internal static class DllCall
    {
        [DllImport("kernel32", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        internal static extern bool ReadProcessMemory
        (
            [In] IntPtr hProcess,
            [In] IntPtr lpBaseAddress,
            [Out] byte[] lpBuffer,
            [In] int dwSize,
            [Out] out int lpNumberOfBytesRead
        );

        [DllImport("kernel32", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        internal static extern bool VirtualProtectEx
        (
            [In] IntPtr hProcess,
            [In] IntPtr lpAddress,
            [In] int dwSize,
            [In] uint flNewProtect,
            [Out] out uint lpflOldProtect
        );

        [DllImport("kernel32", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        internal static extern bool WriteProcessMemory
        (
            [In] IntPtr hProcess,
            [In] IntPtr lpBaseAddress,
            [In] byte[] lpBuffer,
            [In] int nSize,
            [Out] out int lpNumberOfBytesWritten
        );

        [DllImport("user32", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool PostMessage
        (
            [In] IntPtr hWnd,
            [In] uint Msg,
            [In] uint wParam,
            [In] uint lParam
        );
    }
}
