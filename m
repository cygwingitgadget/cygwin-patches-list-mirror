Return-Path: <cygwin-patches-return-4798-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7143 invoked by alias); 31 May 2004 22:49:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7025 invoked from network); 31 May 2004 22:49:22 -0000
Message-Id: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 31 May 2004 22:49:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: NUL and other special names
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1086057971==_"
X-SW-Source: 2004-q2/txt/msg00150.txt.bz2

--=====================_1086057971==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 670

This patch prevents NtCreateFile from creating files with special
names such as NUL.
Because this needs to be checked very often, I tried to code it
efficiently with a binary search (it can perhaps be reused elsewhere). 

The new function is_special_name() overlaps with special_name(),
although there are small differences (it was designed from tests
on XP Home Ed). Perhaps these two can be merged one day.

Pierre

2004-05-31  Pierre Humblet <pierre.humblet@ieee.org>

	* winsup.h: Declare DIM macro.
	(find_in_list): Declare function.
	* miscfunc.c (find_in_list): New function.
	* path.cc (is_special_name): New function.
	(path_conv::check): Call is_special_name.

--=====================_1086057971==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="special.diff"
Content-length: 4724

Index: winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.147
diff -u -p -r1.147 winsup.h
--- winsup.h	17 May 2004 15:27:56 -0000	1.147
+++ winsup.h	31 May 2004 22:33:56 -0000
@@ -29,6 +29,7 @@ details. */
 # define memset __builtin_memset
 #endif

+#define DIM(x) (sizeof (x) / sizeof ((x)[0]))
 #define NO_COPY __attribute__((nocommon)) __attribute__((section(".data_cy=
gwin_nocopy")))
 #define NO_COPY_INIT __attribute__((section(".data_cygwin_nocopy")))

@@ -245,10 +246,16 @@ void __stdcall nofinalslash (const char
 extern "C" char *__stdcall rootdir (const char *full_path, char *root_path=
) __attribute__ ((regparm(2)));

 /* String manipulation */
+typedef struct {
+  const unsigned char length;
+  const char * name;
+} name_list;
+
 extern "C" char *__stdcall strccpy (char *s1, const char **s2, char c);
 extern "C" int __stdcall strcasematch (const char *s1, const char *s2) __a=
ttribute__ ((regparm(2)));
 extern "C" int __stdcall strncasematch (const char *s1, const char *s2, si=
ze_t n) __attribute__ ((regparm(3)));
 extern "C" char *__stdcall strcasestr (const char *searchee, const char *l=
ookfor) __attribute__ ((regparm(2)));
+extern int find_in_list (const char *, const name_list *, int);

 /* Time related */
 void __stdcall totimeval (struct timeval *dst, FILETIME * src, int sub, in=
t flag);
Index: miscfuncs.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.30
diff -u -p -r1.30 miscfuncs.cc
--- miscfuncs.cc	26 Feb 2004 11:32:20 -0000	1.30
+++ miscfuncs.cc	31 May 2004 22:33:57 -0000
@@ -144,6 +144,26 @@ strcasestr (const char *searchee, const
   return NULL;
 }

+/* Return TRUE if find name in name_list */
+int
+find_in_list (const char * name, const name_list * list, int dim)
+{
+  int start =3D 0, end =3D dim - 1, curr, res;
+  do
+    {
+      curr =3D (start + end) / 2;
+      if (!(res =3D strncasecmp (name, list[curr].name, list[curr].length)=
))
+	return curr;
+      if (res < 0)
+	end =3D curr - 1;
+      else
+	start =3D curr + 1;
+    }
+  while (start <=3D end);
+  return -1;
+}
+
+
 int __stdcall
 check_null_str (const char *name)
 {
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.314
diff -u -p -r1.314 path.cc
--- path.cc	31 May 2004 02:20:39 -0000	1.314
+++ path.cc	31 May 2004 22:34:03 -0000
@@ -482,6 +482,61 @@ path_conv::get_nt_native_path (UNICODE_S
   return &upath;
 }

+/* Keep sorted */
+const name_list special_names[] =3D {
+  {3, "AUX"},
+  {7, "CLOCK$"}, /* Include final 0 */
+  {3, "COM"},
+  {3, "CON"},
+  {3, "LPT"},
+  {3, "NUL"},
+  {3, "PRN"}
+};
+
+static bool
+is_special_name (const char * name)
+{
+  bool res =3D false;
+  const char *currptr;
+  int pos;
+
+  if ((currptr =3D strrchr (name, '\\'))
+      && (pos =3D find_in_list (++currptr, special_names, DIM (special_nam=
es))) >=3D 0
+      && !strncasematch (name, "\\\\.\\", 4))
+    {
+      currptr +=3D special_names[pos].length;
+      switch (pos)
+        {
+	  /* CLOCK$ must match exactly. */
+	case 1:
+	  res =3D true;
+	  break;
+	  /* COM and LPT must be followed by a single digit */
+	case 2:
+	case 4:
+	  res =3D *currptr >=3D '0' && *currptr <=3D '9' && currptr[1] =3D=3D '\0=
';
+	  break;
+	  /* CON */
+	case 3:
+	  /* CONIN$ and CONOUT$ must match exactly */
+	  if (!strcasecmp (currptr, "IN$")
+	      || !strcasecmp (currptr, "OUT$"))
+	    {
+	      res =3D true;
+	      break;
+	    }
+	  /* Fall through */
+	  /* Others can have an arbitray extension */
+	default:
+	  res =3D *currptr =3D=3D '\0' || *currptr =3D=3D '.';
+	  break;
+	}
+    }
+
+  debug_printf ("%d =3D is_special_name (%s)", res, name);
+  return res;
+}
+
 /* Convert an arbitrary path SRC to a pure Win32 path, suitable for
    passing to Win32 API routines.

@@ -837,6 +892,13 @@ out:

   if (dev.devn =3D=3D FH_FS)
     {
+      /* Check if the file is special */
+      if (wincap.is_winnt () && pcheck_case !=3D PCHECK_STRICT
+	  && is_special_name (this->path))
+        {
+	  error =3D ENOENT;
+	  return;
+	}
       if (fs.update (path))
 	{
 	  set_isdisk ();

--=====================_1086057971==_--
