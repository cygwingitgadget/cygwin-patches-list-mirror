From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Make fiber functions "external __inline"
Date: Sun, 08 Apr 2001 17:52:00 -0000
Message-id: <20010408205211.A23411@redhat.com>
X-SW-Source: 2001-q2/msg00017.html

The recent changes to the fiber functions in winnt.h cause inclusion of
the inline assembler code in any file which includes winnt.h.  The patch
below fixes this.

I also changed the multi-line string to include a \n\ at the end of
every line since newer gcc's complain about multi-line strings otherwise
(sic).

cgf

Sun Apr  8 20:48:01 2001  Christopher Faylor <cgf@cygnus.com>

	* include/winnt.h (GetCurrentFiber): Make "external __inline" or asm
	code will be included in every module which includes this header.
	(GetFiberData): Ditto.

Index: include/winnt.h
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/include/winnt.h,v
retrieving revision 1.18
diff -u -p -r1.18 winnt.h
--- winnt.h     2001/04/08 17:00:27     1.18
+++ winnt.h     2001/04/09 00:47:51
@@ -2499,22 +2499,22 @@ typedef struct _REPARSE_POINT_INFORMATIO
	WORD   ReparseDataLength;
	WORD   UnparsedNameLength;
 } REPARSE_POINT_INFORMATION, *PREPARSE_POINT_INFORMATION;
-__inline PVOID GetCurrentFiber(void)
+extern __inline PVOID GetCurrentFiber(void)
 {
     void* ret;
-    __asm__ volatile ("
-             movl      %%fs:0x10,%0
-             movl      (%0),%0
+    __asm__ volatile ("\n\
+             movl      %%fs:0x10,%0\n\
+             movl      (%0),%0\n\
	      " : "=r" (ret) /* allow use of reg eax, ebx, ecx, edx, esi, edi */
		:
	      );
     return ret;
 }
-__inline PVOID GetFiberData(void)
+extern __inline PVOID GetFiberData(void)
 {
     void* ret;
-    __asm__ volatile ("
-             movl      %%fs:0x10,%0
+    __asm__ volatile ("\n\
+             movl      %%fs:0x10,%0\n\
	      " : "=r" (ret) /* allow use of reg eax,ebx,ecx,edx,esi,edi */
		:
		);
