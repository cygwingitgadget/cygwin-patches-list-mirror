From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: winsup/cygwin/Makefile.in tweak to install profiling code
Date: Thu, 04 May 2000 14:51:00 -0000
Message-id: <20000504175117.A21647@cygnus.com>
References: <200005041829.NAA09844@pluto.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00037.html

Looks good.  Go ahead and check this in.
cgf

On Thu, May 04, 2000 at 01:29:15PM -0500, Mumit Khan wrote:
>The profile startup/library were not being installed since the reorg.
>
>2000-05-04  Mumit Khan  <khan@xraylith.wisc.edu>
>
>	* Makefile.in (install): Install profile startup and library.
>
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>retrieving revision 1.6
>diff -u -3 -p -r1.6 Makefile.in
>--- Makefile.in	2000/04/26 18:19:22	1.6
>+++ Makefile.in	2000/05/04 18:27:03
>@@ -143,7 +143,9 @@ force:
> 
> install: all
> 	$(INSTALL_DATA) new-$(DLL_NAME) $(bindir)/$(DLL_NAME) ; \
>-	$(INSTALL_DATA) $(LIB_NAME) $(tooldir)/lib/$(LIB_NAME); \
>+	for i in $(LIB_NAME) $(GMON_START) $(LIBGMON_A) ; do \
>+	    $(INSTALL_DATA) $$i $(tooldir)/lib/$$i ; \
>+	done ; \
> 	cd $(srcdir); \
> 	for sub in `find include -name '[a-z]*' -type d -print | sort`; do \
> 	    for i in $$sub/*.h ; do \
