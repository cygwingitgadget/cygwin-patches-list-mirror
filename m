Return-Path: <cygwin-patches-return-2386-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9095 invoked by alias); 11 Jun 2002 00:18:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9080 invoked from network); 11 Jun 2002 00:18:08 -0000
Message-ID: <021201c210dd$af3db970$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: shmctl(2) patch
Date: Mon, 10 Jun 2002 17:18:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_020F_01C210E6.10A97A20"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00369.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_020F_01C210E6.10A97A20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1518

Attached is a patch to add the shmctl(2) interfaces required by ipcs(8)
(following Linux's example tho' not their exact implementation or code).
While I was at it, I've also made the following changes:

*) Added spare fields to the existing shmid_ds structure for future
expansion; ditto for the new shminfo structure. (Tip of the hat to Linux
there.)

*) There was a problem with having two types called shmid_ds (one a class
for internal use, another a struct for i/face use), which was that they are
both needed to implement shmctl(2) in the dll. So, I've given them different
names, so they can co-exist, and made the class have an instance of the
structure as a field.

*) And I shuffled things around in the two header files in the process: it
satisfies my sense of aesthetics now, YMMV :-)

The ipctests compile and work against these new headers files (i.e. they're
source, tho' not binary, compatible with the previous versions).

I'll go back to looking to see if I can get the shm sub-system working with
the socket transport next (or, at least, trying to understand why it doesn't
work at the moment).

Cheers.

// Conrad

2002-06-10  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * include/sys/ipc.h: Reorganize file. Add IPC_INFO flag.
 * include/sys/shm.h: Reorganize file. Add SHM_STAT flag.
 (struct shmid_ds): Add spare fields.
 (struct shminfo): New struct.
 (class cygshmid_ds): New class to replace internal shmid_ds class.
 * cygserver_shm.cc: Update for new cygshmid_ds class.
 * shm.cc: Ditto.


------=_NextPart_000_020F_01C210E6.10A97A20
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 382

2002-06-10  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/sys/ipc.h: Reorganize file. Add IPC_INFO flag.
	* include/sys/shm.h: Reorganize file. Add SHM_STAT flag.
	(struct shmid_ds): Add spare fields.
	(struct shminfo): New struct.
	(class cygshmid_ds): New class to replace internal shmid_ds class.
	* cygserver_shm.cc: Update for new cygshmid_ds class.
	* shm.cc: Ditto.

------=_NextPart_000_020F_01C210E6.10A97A20
Content-Type: application/octet-stream;
	name="shmctl.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="shmctl.patch"
Content-length: 11717

diff -u -r -x CVS /pack/src/cygwin/HEAD.src/winsup/cygwin/cygserver_shm.cc =
./cygserver_shm.cc=0A=
--- /pack/src/cygwin/HEAD.src/winsup/cygwin/cygserver_shm.cc	2002-06-11 00:=
30:53.000000000 +0100=0A=
+++ ./cygserver_shm.cc	2002-06-11 01:09:31.000000000 +0100=0A=
@@ -106,7 +106,7 @@=0A=
  * attach count and attachees list=0A=
  */=0A=
=20=0A=
-  InterlockedIncrement (&shm->shm_nattch);=0A=
+  InterlockedIncrement (&shm->ds.shm_nattch);=0A=
   _shmattach *=0A=
     attachnode =3D=0A=
     new=0A=
@@ -297,7 +297,7 @@=0A=
 	{=0A=
 	  if (tempnode->shm_id =3D=3D parameters.in.shm_id)=0A=
 	    {=0A=
-	      InterlockedIncrement (&tempnode->shmds->shm_nattch);=0A=
+	      InterlockedIncrement (&tempnode->shmds->ds.shm_nattch);=0A=
 	      header.error_code =3D 0;=0A=
 	      CloseHandle (token_handle);=0A=
 	      return;=0A=
@@ -317,7 +317,7 @@=0A=
 	{=0A=
 	  if (tempnode->shm_id =3D=3D parameters.in.shm_id)=0A=
 	    {=0A=
-	      InterlockedDecrement (&tempnode->shmds->shm_nattch);=0A=
+	      InterlockedDecrement (&tempnode->shmds->ds.shm_nattch);=0A=
 	      header.error_code =3D 0;=0A=
 	      CloseHandle (token_handle);=0A=
 	      return;=0A=
@@ -417,7 +417,7 @@=0A=
 	    {=0A=
 	      // FIXME: free the mutex=0A=
 	      if (parameters.in.size=0A=
-		  && tempnode->shmds->shm_segsz < parameters.in.size)=0A=
+		  && tempnode->shmds->ds.shm_segsz < parameters.in.size)=0A=
 		{=0A=
 		  header.error_code =3D EINVAL;=0A=
 		  CloseHandle (token_handle);=0A=
@@ -573,7 +573,7 @@=0A=
 	  return;=0A=
 	}=0A=
=20=0A=
-      shmid_ds *shmtemp =3D new shmid_ds;=0A=
+      cygshmid_ds *shmtemp =3D new cygshmid_ds;=0A=
       if (!shmtemp)=0A=
 	{=0A=
 	  system_printf ("failed to malloc shm node");=0A=
@@ -587,18 +587,13 @@=0A=
 	}=0A=
=20=0A=
       /* fill out the node data */=0A=
-      shmtemp->shm_perm.cuid =3D getuid ();=0A=
-      shmtemp->shm_perm.uid =3D shmtemp->shm_perm.cuid;=0A=
-      shmtemp->shm_perm.cgid =3D getgid ();=0A=
-      shmtemp->shm_perm.gid =3D shmtemp->shm_perm.cgid;=0A=
-      shmtemp->shm_perm.mode =3D parameters.in.shmflg & 0x01ff;=0A=
-      shmtemp->shm_lpid =3D 0;=0A=
-      shmtemp->shm_nattch =3D 0;=0A=
-      shmtemp->shm_atime =3D 0;=0A=
-      shmtemp->shm_dtime =3D 0;=0A=
-      shmtemp->shm_ctime =3D time (NULL);=0A=
-      shmtemp->shm_segsz =3D parameters.in.size;=0A=
-      *(shmid_ds *) mapptr =3D *shmtemp;=0A=
+      memset(shmtemp, '\0', sizeof(*shmtemp));=0A=
+      shmtemp->ds.shm_perm.cuid =3D shmtemp->ds.shm_perm.uid =3D getuid ()=
;=0A=
+      shmtemp->ds.shm_perm.cgid =3D shmtemp->ds.shm_perm.gid =3D getgid ()=
;=0A=
+      shmtemp->ds.shm_perm.mode =3D parameters.in.shmflg & 0x01ff;=0A=
+      shmtemp->ds.shm_ctime =3D time (NULL);=0A=
+      shmtemp->ds.shm_segsz =3D parameters.in.size;=0A=
+      *(cygshmid_ds *) mapptr =3D *shmtemp;=0A=
       shmtemp->mapptr =3D mapptr;=0A=
=20=0A=
       /* no need for InterlockedExchange here, we're serialised by the glo=
bal mutex */=0A=
diff -u -r -x CVS /pack/src/cygwin/HEAD.src/winsup/cygwin/include/sys/ipc.h=
 ./include/sys/ipc.h=0A=
--- /pack/src/cygwin/HEAD.src/winsup/cygwin/include/sys/ipc.h	2002-03-05 12=
:58:21.000000000 +0000=0A=
+++ ./include/sys/ipc.h	2002-06-11 00:58:54.000000000 +0100=0A=
@@ -9,16 +9,19 @@=0A=
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
 details. */=0A=
=20=0A=
+#ifndef _SYS_IPC_H=0A=
+#define _SYS_IPC_H=0A=
+=0A=
+#include <sys/types.h>=0A=
+=0A=
 #ifdef __cplusplus=0A=
 extern "C"=0A=
 {=0A=
 #endif=0A=
=20=0A=
-#ifndef _SYS_IPC_H=0A=
-#define _SYS_IPC_H=0A=
-=0A=
-/* sys/types must be included before sys/ipc.h. We aren't meant to automat=
ically=20=0A=
- * include it however=20=0A=
+/*=0A=
+ * <sys/types> must be included before <sys/ipc.h>. We aren't meant to=0A=
+ * automatically include it however.=0A=
  */=0A=
=20=0A=
 struct ipc_perm {=0A=
@@ -29,25 +32,27 @@=0A=
   mode_t mode;=0A=
 };=20=0A=
=20=0A=
-/* the mode flags used with the _get functions use the low order 9 bits fo=
r a mode=20=0A=
- * request=0A=
+/*=0A=
+ * The mode flags used with the _get functions use the low order 9=0A=
+ * bits for a mode request.=0A=
  */=0A=
 #define IPC_CREAT  0x0200=0A=
 #define IPC_EXCL   0x0400=0A=
 #define IPC_NOWAIT 0x0800=0A=
=20=0A=
-/* this is a value that will _never_ be a valid key from ftok */=0A=
-#define IPC_PRIVATE -2=0A=
-=0A=
-/* ctl commands 1000-1fff is ipc reserved */=0A=
-#define IPC_RMID 0x1003=0A=
-#define IPC_SET  0x1002=0A=
-#define IPC_STAT 0x1001=0A=
+/* This is a value that will _never_ be a valid key from ftok(3). */=0A=
+#define IPC_PRIVATE ((key_t) -2)=0A=
=20=0A=
-key_t ftok(const char *, int);=0A=
+/* xxxctl(2) commands 1000-1fff is ipc reserved */=0A=
+#define IPC_RMID 0x1000=0A=
+#define IPC_SET  0x1001=0A=
+#define IPC_STAT 0x1002=0A=
+#define IPC_INFO 0x1003		/* For ipcs(8). */=0A=
=20=0A=
-#endif /* _SYS_IPC_H */=0A=
+key_t ftok(const char * path, int id);=0A=
=20=0A=
 #ifdef __cplusplus=0A=
 }=0A=
 #endif=0A=
+=0A=
+#endif /* _SYS_IPC_H */=0A=
diff -u -r -x CVS /pack/src/cygwin/HEAD.src/winsup/cygwin/include/sys/shm.h=
 ./include/sys/shm.h=0A=
--- /pack/src/cygwin/HEAD.src/winsup/cygwin/include/sys/shm.h	2002-02-28 14=
:30:38.000000000 +0000=0A=
+++ ./include/sys/shm.h	2002-06-11 00:58:54.000000000 +0100=0A=
@@ -9,25 +9,67 @@=0A=
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
 details. */=0A=
=20=0A=
+#ifndef _SYS_SHM_H=0A=
+#define _SYS_SHM_H=0A=
+=0A=
+#include <sys/ipc.h>=0A=
+=0A=
 #ifdef __cplusplus=0A=
 extern "C"=0A=
 {=0A=
 #endif=0A=
=20=0A=
-#ifndef _SYS_SHM_H=0A=
-#define _SYS_SHM_H=0A=
-=0A=
-#include <sys/ipc.h>=0A=
+/*=0A=
+ * 64 Kb was hardcoded for x86. MS states this may change, but we need=0A=
+ * it in the header file.=0A=
+ */=0A=
+#define SHMLBA 65536=0A=
=20=0A=
-#define SHM_RDONLY 1=0A=
-/* 64 Kb was hardcoded for x86. MS states this may change, but we need it =
in the header=0A=
- * file.=0A=
+/*=0A=
+ * Values for the shmflg argument to shmat(2).=0A=
  */=0A=
-#define SHMLBA     65536=0A=
-#define SHM_RND	   1=0A=
+#define SHM_RDONLY 0x01		/* Attach read-only, not read/write. */=0A=
+#define SHM_RND    0x02		/* Round shmaddr down to multiple of SHMLBA. */=
=0A=
+=0A=
+/* xxxctl(2) commands 4000-4fff are reserved for shmctl(2). */=0A=
+#define SHM_STAT   0x4000	/* For ipcs(8) */=0A=
=20=0A=
 typedef long int shmatt_t;=0A=
=20=0A=
+struct shmid_ds {=0A=
+  struct ipc_perm shm_perm;=0A=
+  size_t          shm_segsz;=0A=
+  pid_t           shm_lpid;=0A=
+  pid_t           shm_cpid;=0A=
+  shmatt_t        shm_nattch;=0A=
+  time_t          shm_atime;=0A=
+  long            shm_spare1;=0A=
+  time_t          shm_dtime;=0A=
+  long            shm_spare2;=0A=
+  time_t          shm_ctime;=0A=
+  long            shm_spare3;=0A=
+  long            shm_spare4[2];=0A=
+};=0A=
+=0A=
+/* Buffer type for shmctl(IPC_INFO, ...); for ipcs(8). */=0A=
+struct shminfo {=0A=
+  unsigned long shmmax;=0A=
+  unsigned long shmmin;=0A=
+  unsigned long shmmni;=0A=
+  unsigned long shmseg;=0A=
+  unsigned long shmall;=0A=
+  unsigned long shm_spare[4];=0A=
+};=0A=
+=0A=
+void *shmat(int shmid, const void *shmaddr, int shmflg);=0A=
+int   shmctl(int shmid, int cmd, struct shmid_ds *buf);=0A=
+int   shmdt(const void *shmaddr);=0A=
+int   shmget(key_t key, size_t size, int shmflg);=0A=
+=0A=
+#ifdef __cplusplus=0A=
+}=0A=
+#endif=0A=
+=0A=
 #if defined(__INSIDE_CYGWIN__) && defined(__cplusplus)=0A=
=20=0A=
 class _shmattach {=0A=
@@ -37,22 +79,15 @@=0A=
   class _shmattach *next;=0A=
 };=0A=
=20=0A=
-class shmid_ds {=0A=
+class cygshmid_ds {=0A=
 public:=0A=
-  struct   ipc_perm shm_perm;=0A=
-  size_t   shm_segsz;=0A=
-  pid_t    shm_lpid;=0A=
-  pid_t    shm_cpid;=0A=
-  shmatt_t shm_nattch;=0A=
-  time_t   shm_atime;=0A=
-  time_t   shm_dtime;=0A=
-  time_t   shm_ctime;=0A=
+  struct shmid_ds ds;=0A=
   void *mapptr;=0A=
 };=0A=
=20=0A=
 class shmnode {=0A=
 public:=0A=
-  class shmid_ds * shmds;=0A=
+  class cygshmid_ds * shmds;=0A=
   int shm_id;=0A=
   class shmnode *next;=0A=
   key_t key;=0A=
@@ -61,29 +96,6 @@=0A=
   class _shmattach *attachhead;=0A=
 };=0A=
=20=0A=
-#else=0A=
-/* this is what we return when queried. It has no bitwise correspondence=
=0A=
- * the internal structures=20=0A=
- */=0A=
-struct shmid_ds {=0A=
-  struct   ipc_perm shm_perm;=0A=
-  size_t   shm_segsz;=0A=
-  pid_t    shm_lpid;=0A=
-  pid_t    shm_cpid;=0A=
-  shmatt_t shm_nattch;=0A=
-  time_t   shm_atime;=0A=
-  time_t   shm_dtime;=0A=
-  time_t   shm_ctime;=0A=
-};=0A=
 #endif /* __INSIDE_CYGWIN__ */=0A=
=20=0A=
-void *shmat(int, const void *, int);=0A=
-int   shmctl(int, int, struct shmid_ds *);=0A=
-int   shmdt(const void *);=0A=
-int   shmget(key_t, size_t, int);=0A=
-=0A=
 #endif /* _SYS_SHM_H */=0A=
-=0A=
-#ifdef __cplusplus=0A=
-}=0A=
-#endif=0A=
diff -u -r -x CVS /pack/src/cygwin/HEAD.src/winsup/cygwin/shm.cc ./shm.cc=
=0A=
--- /pack/src/cygwin/HEAD.src/winsup/cygwin/shm.cc	2002-06-06 21:35:34.0000=
00000 +0100=0A=
+++ ./shm.cc	2002-06-11 00:49:33.000000000 +0100=0A=
@@ -98,7 +98,7 @@=0A=
=20=0A=
   /* Now get the user data */=0A=
   HANDLE attachmap =3D hattachmap;=0A=
-  shmid_ds *shmtemp =3D new shmid_ds;=0A=
+  cygshmid_ds *shmtemp =3D new cygshmid_ds;=0A=
   if (!shmtemp)=0A=
     {=0A=
       system_printf ("failed to malloc shm node\n");=0A=
@@ -111,7 +111,7 @@=0A=
     }=0A=
=20=0A=
   /* get the system node data */=0A=
-  *shmtemp =3D *(shmid_ds *) mapptr;=0A=
+  *shmtemp =3D *(cygshmid_ds *) mapptr;=0A=
=20=0A=
   /* process local data */=0A=
   shmnode *tempnode =3D new shmnode;=0A=
@@ -176,7 +176,7 @@=0A=
 			 tempnode);=0A=
 	  return 1;=0A=
 	}=0A=
-      tempnode->shmds =3D (class shmid_ds *) newshmds;=0A=
+      tempnode->shmds =3D (class cygshmid_ds *) newshmds;=0A=
       tempnode->shmds->mapptr =3D newshmds;=0A=
       _shmattach *attachnode =3D tempnode->attachhead;=0A=
       while (attachnode)=0A=
@@ -256,7 +256,7 @@=0A=
=20=0A=
     }=0A=
=20=0A=
-  // class shmid_ds *shm =3D tempnode->shmds;=0A=
+  // class cygshmid_ds *shm =3D tempnode->shmds;=0A=
=20=0A=
   if (shmaddr)=0A=
     {=0A=
@@ -384,21 +384,14 @@=0A=
   switch (cmd)=0A=
     {=0A=
     case IPC_STAT:=0A=
-      buf->shm_perm =3D tempnode->shmds->shm_perm;=0A=
-      buf->shm_segsz =3D tempnode->shmds->shm_segsz;=0A=
-      buf->shm_lpid =3D tempnode->shmds->shm_lpid;=0A=
-      buf->shm_cpid =3D tempnode->shmds->shm_cpid;=0A=
-      buf->shm_nattch =3D tempnode->shmds->shm_nattch;=0A=
-      buf->shm_atime =3D tempnode->shmds->shm_atime;=0A=
-      buf->shm_dtime =3D tempnode->shmds->shm_dtime;=0A=
-      buf->shm_ctime =3D tempnode->shmds->shm_ctime;=0A=
+      *buf =3D tempnode->shmds->ds;=0A=
       break;=0A=
     case IPC_RMID:=0A=
       {=0A=
 	/* TODO: check permissions. Or possibly, the daemon gets to be the only=
=0A=
 	 * one with write access to the memory area?=0A=
 	 */=0A=
-	if (tempnode->shmds->shm_nattch)=0A=
+	if (tempnode->shmds->ds.shm_nattch)=0A=
 	  system_printf=0A=
 	    ("call to shmctl with cmd=3D IPC_RMID when memory area still has"=0A=
 	     " attachees\n");=0A=
@@ -482,7 +475,7 @@=0A=
       if (tempnode->key =3D=3D key && key !=3D IPC_PRIVATE)=0A=
 	{=0A=
 	  // FIXME: free the mutex=0A=
-	  if (size && tempnode->shmds->shm_segsz < size)=0A=
+	  if (size && tempnode->shmds->ds.shm_segsz < size)=0A=
 	    {=0A=
 	      set_errno (EINVAL);=0A=
 	      return -1;=0A=
@@ -549,7 +542,7 @@=0A=
   shmtemp->shm_dtime =3D 0;=0A=
   shmtemp->shm_ctime =3D time (NULL);=0A=
   shmtemp->shm_segsz =3D size;=0A=
-  *(shmid_ds *) mapptr =3D *shmtemp;=0A=
+  *(cygshmid_ds *) mapptr =3D *shmtemp;=0A=
   shmtemp->filemap =3D filemap;=0A=
   shmtemp->attachmap =3D attachmap;=0A=
   shmtemp->mapptr =3D mapptr;=0A=

------=_NextPart_000_020F_01C210E6.10A97A20--

