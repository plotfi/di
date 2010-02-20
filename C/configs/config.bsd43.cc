#ifndef __INC_CONFIG_H
#define __INC_CONFIG_H 1

#define _hdr_stdlib 0
#define _hdr_stdio 1
#define _sys_types 1
#define _sys_param 1
#define _key_void 1
#define _key_const 0
#define _proto_stdc 0
#define _hdr_ctype 1
#define _hdr_errno 1
#define _hdr_fcntl 1
#define _hdr_fshelp 0
#define _hdr_getopt 0
#define _hdr_kernel_fs_info 0
#define _hdr_limits 0
#define _hdr_libintl 0
#define _hdr_locale 0
#define _hdr_malloc 0
#define _hdr_memory 1
#define _hdr_mntent 1
#define _hdr_mnttab 0
#define _hdr_storage_Directory 0
#define _hdr_storage_Entry 0
#define _hdr_storage_Path 0
#define _hdr_gui_window 0
#define _hdr_storage_volumes 0
#define _hdr_string 1
#define _hdr_strings 1
#define _hdr_time 1
#define _hdr_unistd 0
#define _hdr_util_string 0
#define _hdr_windows 0
#define _hdr_zone 0
#define _sys_file 1
#define _sys_fs_types 0
#define _sys_fstyp 0
#define _sys_fstypes 0
#define _sys_mntctl 0
#define _sys_mntent 0
#define _sys_mnttab 0
#define _sys_mount 1
#define _sys_stat 1
#define _sys_statfs 0
#define _sys_statvfs 0
#define _sys_time 1
#define _sys_vfs 1
#define _sys_vfstab 0
#define _sys_vmount 0
#define _include_malloc 1
#define _include_string 1
#define _include_time 0
#define _command_msgfmt 0
#define _command_gmsgfmt 0
#define _const_O_NOCTTY 0
#define _typ_statvfs_t 0
#define _typ_size_t 1
#define _typ_uint_t 0
#define _typ_uid_t 1
#define _lib_bcopy 1
#define _lib_bindtextdomain 0
#define _lib_bzero 1
#define _lib_endmntent 1
#define _lib_fs_stat_dev 0
#define _lib_fshelp 0
#define _lib_GetDiskFreeSpace 0
#define _lib_GetDiskFreeSpaceEx 0
#define _lib_GetDriveType 0
#define _lib_getfsstat 0
#define _lib_GetLogicalDriveStrings 0
#define _lib_GetVolumeInformation 0
#define _lib_getmnt 0
#define _lib_getmntent 1
#define _lib_getmntinfo 0
#define _lib_getopt 1
#define _lib_gettext 0
#define _lib_getvfsstat 0
#define _lib_getzoneid 0
#define _lib_hasmntopt 0
#define _lib_memcpy 1
#define _lib_memset 1
#define _lib_mntctl 0
#define _lib_next_dev 0
#define _lib_setlocale 0
#define _lib_setmntent 1
#define _lib_snprintf 0
#define _lib_statfs 1
#define _lib_statvfs 0
#define _lib_strdup 0
#define _lib_strstr 0
#define _lib_sysfs 0
#define _lib_textdomain 0
#define _lib_zone_getattr 0
#define _lib_zone_list 0
#define _setmntent_args 2
#define _statfs_args 2
#define _class_os__Volumes 0
#define _npt_getopt 1
#define _npt_getenv 1
#define _npt_statfs 0
#define _dcl_errno 0
#define _dcl_optind 0
#define _dcl_optarg 0
#define _mem_f_bsize_statfs 1
#define _mem_f_fsize_statfs 0
#define _mem_f_fstyp_statfs 0
#define _mem_f_iosize_statfs 0
#define _mem_f_frsize_statfs 0
#define _mem_f_fstypename_statfs 0
#define _mem_mount_info_statfs 0
#define _mem_f_type_statfs 0
#define _mem_mnt_time_mnttab 0
#define _mem_vmt_time_vmount 0
#define _siz_long_long 0

#if ! _key_void || ! _proto_stdc
# define void int
#endif
#if ! _key_const || ! _proto_stdc
# define const
#endif

#ifndef _
# if _proto_stdc
#  define _(args) args
# else
#  define _(args) ()
# endif
#endif


#if _lib_bindtextdomain && \
    _lib_gettext && \
    _lib_setlocale && \
    _lib_textdomain && \
    _hdr_libintl && \
    _hdr_locale && \
    (_command_msgfmt || _command_gmsgfmt)
# define _enable_nls 1
#else
# define _enable_nls 0
#endif

#if _typ_statvfs_t
# define Statvfs_t statvfs_t
#else
# define Statvfs_t struct statvfs
#endif

#if _typ_size_t
# define Size_t size_t
#else
# define Size_t unsigned int
#endif

#if _typ_uint_t
# define Uint_t uint_t
#else
# define Uint_t unsigned int
#endif

#if _typ_uid_t
# define Uid_t uid_t
#else
# define Uid_t int
#endif

#if _lib_snprintf
# define Snprintf snprintf
# define DI_SPF(a2,a3)         a2,a3
#else
# define Snprintf sprintf
# define DI_SPF(a2,a3)         a3
#endif


#endif /* __INC_CONFIG_H */
