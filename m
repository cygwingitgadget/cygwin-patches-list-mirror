Return-Path: <cygwin-patches-return-6887-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14071 invoked by alias); 9 Jan 2010 13:34:05 -0000
Received: (qmail 14060 invoked by uid 22791); 9 Jan 2010 13:34:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 13:33:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3D6F76D417D; Sat,  9 Jan 2010 14:33:48 +0100 (CET)
Date: Sat, 09 Jan 2010 13:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix misc aliasing warnings.
Message-ID: <20100109133348.GO23992@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B486906.4000600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B486906.4000600@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00003.txt.bz2

On Jan  9 11:31, Dave Korn wrote:
> 
>     Hi gang,
> 
>   Here's a bunch of fixes for more sensitive aliasing warnings present in
> gcc-4.5.0.
> 
> winsup/cygwin/ChangeLog:
> 
> 	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Add new
> 	overload that accepts LARGE_INTEGER rather than FILETIME arguments.
> 	(fhandler_base::fstat_by_handle): Don't alias arguments in call
> 	to fstat_helper, allowing new overload to resolve invocation.
> 	(fhandler_base::fstat_by_name): Likewise.
> 	* fhandler.h (fhandler_base::fstat_helper): Prototype new overload.
> 	* fhandler_floppy.cc (fhandler_dev_floppy::get_drive_info): Avoid
> 	aliasing.
> 	* fhandler_proc.cc (format_proc_cpuinfo): Likewise.
> 	* passwd.cc (internal_getpwsid): Avoid sequence point warning.
> 	* syscalls.cc (gethostid): Avoid aliasing.
> 	* include/cygwin/in6.h (IN6_ARE_ADDR_EQUAL): Likewise.

Boy, what a piece of crap, gcc-wise.

Concerning fstat_helper, I don't like to slip another layer into these
calls to pamper an anal-retentive compiler.  I would rather like to fix
this by removing the FILETIME type from the affected places and use
LARGE_INTEGER throughout.  It's not overly tricky, given that FILETIME
time == LARGE_INTEGER kernel time.

> Index: winsup/cygwin/fhandler_floppy.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/fhandler_floppy.cc,v
> retrieving revision 1.55
> diff -p -u -r1.55 fhandler_floppy.cc
> --- winsup/cygwin/fhandler_floppy.cc	24 Jul 2009 20:54:33 -0000	1.55
> +++ winsup/cygwin/fhandler_floppy.cc	9 Jan 2010 08:49:23 -0000
> @@ -56,7 +56,8 @@ fhandler_dev_floppy::get_drive_info (str
>  	__seterrno ();
>        else
>  	{
> -	  di = &((DISK_GEOMETRY_EX *) dbuf)->Geometry;
> +	  DISK_GEOMETRY_EX *dgx = (DISK_GEOMETRY_EX *) dbuf;
> +	  di = &dgx->Geometry;

That's ok, even though I don't understand what gcc has to grouch about
it.  The expressions should be identical.

> Index: winsup/cygwin/fhandler_proc.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
> retrieving revision 1.87
> diff -p -u -r1.87 fhandler_proc.cc
> --- winsup/cygwin/fhandler_proc.cc	9 Jun 2009 09:45:29 -0000	1.87
> +++ winsup/cygwin/fhandler_proc.cc	9 Jan 2010 08:49:23 -0000
> @@ -637,7 +637,9 @@ format_proc_cpuinfo (void *, char *&dest
>  	  read_value ("Identifier", REG_SZ);
>  	  bufptr += __small_sprintf (bufptr, "identifier      : %s\n", szBuffer);
>  	  read_value ("~Mhz", REG_DWORD);
> -	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", *(DWORD *) szBuffer);
> +	  union { char szbuff[sizeof (DWORD)]; DWORD dw; } u;
> +	  memcpy (u.szbuff, szBuffer, sizeof (DWORD));
> +	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", u.dw);

Shouldn't defining szBuffer as a union pointer avoid the need to memcpy?
Like this:

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.87
diff -u -p -r1.87 fhandler_proc.cc
--- fhandler_proc.cc	9 Jun 2009 09:45:29 -0000	1.87
+++ fhandler_proc.cc	9 Jan 2010 13:21:12 -0000
@@ -555,7 +555,7 @@ format_proc_stat (void *, char *&destbuf
 #define read_value(x,y) \
       do {\
 	dwCount = BUFSIZE; \
-	if ((dwError = RegQueryValueEx (hKey, x, NULL, &dwType, (BYTE *) szBuffer, &dwCount)), \
+	if ((dwError = RegQueryValueEx (hKey, x, NULL, &dwType, (BYTE *) szBuffer.s, &dwCount)), \
 	    (dwError != ERROR_SUCCESS && dwError != ERROR_MORE_DATA)) \
 	  { \
 	    debug_printf ("RegQueryValueEx failed retcode %d", dwError); \
@@ -583,7 +583,12 @@ format_proc_cpuinfo (void *, char *&dest
   DWORD dwOldThreadAffinityMask;
   int cpu_number;
   const int BUFSIZE = 256;
-  CHAR szBuffer[BUFSIZE];
+  union
+  {
+    CHAR s[BUFSIZE];
+    DWORD d;
+    unsigned u;
+  } szBuffer;
   tmp_pathbuf tp;
 
   char *buf = tp.c_get ();
@@ -595,9 +600,9 @@ format_proc_cpuinfo (void *, char *&dest
       if (cpu_number)
 	print ("\n");
 
-      __small_sprintf (szBuffer, "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\%d", cpu_number);
+      __small_sprintf (szBuffer.s, "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\%d", cpu_number);
 
-      if ((dwError = RegOpenKeyEx (HKEY_LOCAL_MACHINE, szBuffer, 0, KEY_QUERY_VALUE, &hKey)) != ERROR_SUCCESS)
+      if ((dwError = RegOpenKeyEx (HKEY_LOCAL_MACHINE, szBuffer.s, 0, KEY_QUERY_VALUE, &hKey)) != ERROR_SUCCESS)
 	{
 	  if (dwError == ERROR_FILE_NOT_FOUND)
 	    break;
@@ -633,11 +638,11 @@ format_proc_cpuinfo (void *, char *&dest
 	{
 	  bufptr += __small_sprintf (bufptr, "processor       : %d\n", cpu_number);
 	  read_value ("VendorIdentifier", REG_SZ);
-	  bufptr += __small_sprintf (bufptr, "vendor_id       : %s\n", szBuffer);
+	  bufptr += __small_sprintf (bufptr, "vendor_id       : %s\n", szBuffer.s);
 	  read_value ("Identifier", REG_SZ);
-	  bufptr += __small_sprintf (bufptr, "identifier      : %s\n", szBuffer);
+	  bufptr += __small_sprintf (bufptr, "identifier      : %s\n", szBuffer.s);
 	  read_value ("~Mhz", REG_DWORD);
-	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", *(DWORD *) szBuffer);
+	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", szBuffer.d);
 
 	  print ("flags           :");
 	  if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))
@@ -675,7 +680,7 @@ format_proc_cpuinfo (void *, char *&dest
 	  bufptr += __small_sprintf (bufptr, "vendor_id\t: %s\n",
 				     (char *)vendor_id);
 	  read_value ("~Mhz", REG_DWORD);
-	  unsigned cpu_mhz = *(DWORD *)szBuffer;
+	  unsigned cpu_mhz = szBuffer.d;
 	  if (maxf >= 1)
 	    {
 	      unsigned features2, features1, extra_info, cpuid_sig;
@@ -698,7 +703,7 @@ format_proc_cpuinfo (void *, char *&dest
 	      cpuid (&maxe, &unused, &unused, &unused, 0x80000000);
 	      if (maxe >= 0x80000004)
 		{
-		  unsigned *model_name = (unsigned *) szBuffer;
+		  unsigned *model_name = &szBuffer.u;
 		  cpuid (&model_name[0], &model_name[1], &model_name[2],
 			 &model_name[3], 0x80000002);
 		  cpuid (&model_name[4], &model_name[5], &model_name[6],
@@ -710,7 +715,7 @@ format_proc_cpuinfo (void *, char *&dest
 	      else
 		{
 		  // could implement a lookup table here if someone needs it
-		  strcpy (szBuffer, "unknown");
+		  strcpy (szBuffer.s, "unknown");
 		}
 	      int cache_size = -1,
 		  tlb_size = -1,
@@ -744,7 +749,7 @@ format_proc_cpuinfo (void *, char *&dest
 						 "cpu MHz\t\t: %d\n",
 					 family,
 					 model,
-					 szBuffer + strspn (szBuffer, " 	"),
+					 szBuffer.s + strspn (szBuffer.s, " 	"),
 					 stepping,
 					 cpu_mhz);
 	      if (cache_size >= 0)

> Index: winsup/cygwin/syscalls.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
> retrieving revision 1.548
> diff -p -u -r1.548 syscalls.cc
> --- winsup/cygwin/syscalls.cc	17 Dec 2009 18:33:05 -0000	1.548
> +++ winsup/cygwin/syscalls.cc	9 Jan 2010 08:49:24 -0000
> @@ -3641,8 +3641,12 @@ long gethostid (void)
>      status = UuidCreate (&Uuid);
>    if (status == RPC_S_OK)
>      {
> -      data[4] = *(unsigned *)&Uuid.Data4[2];
> -      data[5] = *(unsigned short *)&Uuid.Data4[6];
> +      unsigned d4;
> +      unsigned short d5;
> +      memcpy (&d4, &Uuid.Data4[2], sizeof (unsigned));
> +      memcpy (&d5, &Uuid.Data4[6], sizeof (unsigned short));
> +      data[4] = d4;
> +      data[5] = d5;

Wouldn't temporary pointers

  unsigned *d4 = (unsigned *)&Uuid.Data4[2];
  unsigned short *d5 = (unsigned short *)&Uuid.Data4[6];
  data[4] = *d4;
  data[5] = *d5;

avoid the memcpy?

> Index: winsup/cygwin/include/cygwin/in6.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/in6.h,v
> retrieving revision 1.6
> diff -p -u -r1.6 in6.h
> --- winsup/cygwin/include/cygwin/in6.h	18 Jan 2007 10:25:40 -0000	1.6
> +++ winsup/cygwin/include/cygwin/in6.h	9 Jan 2010 08:49:24 -0000
> @@ -16,10 +16,7 @@ details. */
>  #define INET6_ADDRSTRLEN 46
>  
>  #define IN6_ARE_ADDR_EQUAL(a, b) \
> -	(((const uint32_t *)(a))[0] == ((const uint32_t *)(b))[0] \
> -	 && ((const uint32_t *)(a))[1] == ((const uint32_t *)(b))[1] \
> -	 && ((const uint32_t *)(a))[2] == ((const uint32_t *)(b))[2] \
> -	 && ((const uint32_t *)(a))[3] == ((const uint32_t *)(b))[3])
> +	(!memcmp ((a), (b), 4 * sizeof (uint32_t)))

Hang on.  That's almost exactly the definition of IN6_ARE_ADDR_EQUAL as
on Linux and on other systems.  If that doesn't work anymore, not only
this one has to be changed, but all the equivalent expressions
throughout netinet/in.h.  The gcc guys aren';t serious about that,
are they?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
