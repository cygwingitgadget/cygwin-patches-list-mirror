From: Corinna Vinschen <vinschen@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH]: Some new (mostly W2K related) stuff in w32api
Date: Tue, 27 Jun 2000 11:43:00 -0000
Message-id: <3958F5D6.81AAB550@cygnus.com>
X-SW-Source: 2000-q2/msg00113.html

First of all, I have created a new import library definition file
for PSAPI.DLL. While psapi.h already exists since January, the
related psapi.def file was still missing.

Then I have added some defines and typedefs to w32api. They are
some sort of by-product while experimenting with new W2K
features:

winbase.h:
==========

Some new stream ids for use in BackupRead(), BackupWrite():
	BACKUP_OBJECT_ID
	BACKUP_REPARSE_DATA
	BACKUP_SPARSE_BLOCK

New file open flags, used in CreateFile():
	FILE_FLAG_OPEN_REPARSE_POINT
	FILE_FLAG_OPEN_NO_RECALL
        
winioctl.h:
===========

New device io control codes for use in DeviceIoControl():
	FSCTL_GET_REPARSE_POINT
	FSCTL_SET_REPARSE_POINT
	FSCTL_DELETE_REPARSE_POINT
	
winnt.h:
========

Added typedef for GUID which is used in later typedefs.

New file attributes returned by GetFileAttribute()
	FILE_ATTRIBUTE_ENCRYPTED
	FILE_ATTRIBUTE_SPARSE_FILE
	FILE_ATTRIBUTE_REPARSE_POINT
	FILE_ATTRIBUTE_NOT_CONTENT_INDEXED

New volume attributes returned by GetVolumeInformation():
	FILE_VOLUME_QUOTAS
	FILE_SUPPORTS_SPARSE_FILES
	FILE_SUPPORTS_REPARSE_POINTS
	FILE_SUPPORTS_REMOTE_STORAGE
	FILE_SUPPORTS_OBJECT_IDS
	FILE_SUPPORTS_ENCRYPTION

Added several reparse point defines and macros:
	REPARSE_DATA_BUFFER_HEADER_SIZE
	REPARSE_GUID_DATA_BUFFER_HEADER_SIZE
	MAXIMUM_REPARSE_DATA_BUFFER_SIZE
	IO_REPARSE_TAG_RESERVED_ZERO
	IO_REPARSE_TAG_RESERVED_ONE
	IO_REPARSE_TAG_RESERVED_RANGE
	IsReparseTagMicrosoft
	IsReparseTagHighLatency
	IsReparseTagNameSurrogate
	IO_REPARSE_TAG_VALID_VALUES
	IsReparseTagValid
	IO_REPARSE_TAG_SYMBOLIC_LINK
	IO_REPARSE_TAG_MOUNT_POINT

and related typedefs:
	REPARSE_DATA_BUFFER
	REPARSE_GUID_DATA_BUFFER
	REPARSE_POINT_INFORMATION

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
