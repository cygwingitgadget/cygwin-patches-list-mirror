From: Chris Faylor <cgf@cygnus.com>
To: Mumit Khan <khan@NanoTech.Wisc.EDU>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: wchar prototype tweaks
Date: Sat, 06 May 2000 09:54:00 -0000
Message-id: <20000506125446.A1189@cygnus.com>
References: <20000506122316.I948@cygnus.com> <Pine.HPP.3.96.1000506113639.27187H-100000@hp2.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00040.html

These look fine, of course.  Let 'er rip.

cgf

On Sat, May 06, 2000 at 11:39:37AM -0500, Mumit Khan wrote:
>On Sat, 6 May 2000, Chris Faylor wrote:
>
>> Don't you have to fix the function definition themselves, too, Mumit?
>
>Argh, forgot to include syscalls.cc in the patch, sorry. 
>
>Trivial prototype fixes. Wish had the time to rig up a more complete
>wchar implementation, but oh well.
>
>2000-05-06  Mumit Khan  <khan@xraylith.wisc.edu>
>
>	* include/wchar.h (wcscmp, wcslen): Fix prototypes.
>	* syscalls.cc (wcslen, wcscmp): Adjust.
>
>Index: include/wchar.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/include/wchar.h,v
>retrieving revision 1.1.1.1
>diff -u -3 -p -r1.1.1.1 wchar.h
>--- include/wchar.h	2000/02/17 19:38:31	1.1.1.1
>+++ include/wchar.h	2000/05/06 16:38:25
>@@ -19,8 +19,8 @@ details. */
> 
> __BEGIN_DECLS
> 
>-int wcscmp (wchar_t *__s1, wchar_t *__s2);
>-int wcslen (wchar_t *__s1);
>+int wcscmp (const wchar_t *__s1, const wchar_t *__s2);
>+size_t wcslen (const wchar_t *__s1);
> 
> __END_DECLS
> 
>Index: syscalls.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
>retrieving revision 1.22
>diff -u -3 -p -r1.22 syscalls.cc
>--- syscalls.cc	2000/05/04 19:46:32	1.22
>+++ syscalls.cc	2000/05/06 16:38:25
>@@ -1836,7 +1836,7 @@ putw (int w, FILE *fp)
> 
> extern "C"
> int
>-wcscmp (wchar_t *s1, wchar_t *s2)
>+wcscmp (const wchar_t *s1, const wchar_t *s2)
> {
>   while (*s1  && *s1 == *s2)
>     {
>@@ -1848,8 +1848,8 @@ wcscmp (wchar_t *s1, wchar_t *s2)
> }
> 
> extern "C"
>-int
>-wcslen (wchar_t *s1)
>+size_t
>+wcslen (const wchar_t *s1)
> {
>   int l = 0;
>   while (s1[l])
