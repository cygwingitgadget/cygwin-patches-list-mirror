From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [RFA] lib/Makefile.in patch
Date: Tue, 18 Sep 2001 09:42:00 -0000
Message-id: <20010918124312.B18932@redhat.com>
X-SW-Source: 2001-q3/msg00165.html

[reposted to appropriate mailing list]
Now that Earnie has reverted the change which added /usr to inst_*
variables, I'd like to revert Makefile.in to its previous "one level of
ifneq" state.  This will make it easier for anyone who is interested in
understanding what is going on in the future.

The patch below just removes what appear to be unnecessary if tests.
The end result is that inst_includedir and inst_libdir should still be
set appropriately but the code in Makefile.in is simpler and more
understandable.

cgf

Index: Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/lib/Makefile.in,v
retrieving revision 1.16
diff -p -4 -r1.16 Makefile.in
*** Makefile.in	2001/09/17 16:15:54	1.16
--- Makefile.in	2001/09/18 16:22:28
*************** infodir = @infodir@
*** 40,59 ****
  #FIXME.  The inst_includedir and inst_libdir need to be modified to use
  #$(tooldir)/usr/include/w32api and $(tooldir)/usr/lib/w32api for the dist 
  #targets.
  ifneq (,$(findstring cygwin,$(target_alias)))
- ifeq ($(build_alias),$(host_alias))
- ifeq ($(prefix),$(config_prefix))
  inst_includedir:=$(tooldir)/include/w32api
  inst_libdir:=$(tooldir)/lib/w32api
- else
- inst_includedir:=$(tooldir)/include/w32api
- inst_libdir:=$(tooldir)/lib/w32api
- endif
- else
- inst_includedir:=$(includedir)
- inst_libdir:=$(libdir)
- endif
  else
  inst_includedir:=$(includedir)
  inst_libdir:=$(libdir)
  endif
--- 40,49 ----
