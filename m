From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [patch] documentation winsup/doc Makefile changes
Date: Tue, 20 Feb 2001 19:23:00 -0000
Message-id: <VA.00000671.003b71c8@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00095.html

I noticed on this as well that it appears the make tries to do something with the 
winsup/doc/testsuite and seems to insist the directory be there.  The documents also 
seem to reference a winsup/doc/sites.texinfo which doesn't exist.  To get the make to 
run I created one that just said the file was missing for some reason. 

2001-02-20  Brian Keener <bkeener@thesoftwaresource.com>
   * Makefile.in (%.html: %.texinfo): Modify for proper syntax for 
   inclusion of source directory.
   (readme.txt): Ditto.
   (faq_html): Modify for proper syntax for Table of Contents.


? winsup/doc/testsuite
? winsup/doc/sites.texinfo
Index: winsup/doc/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/doc/Makefile.in,v
retrieving revision 1.6
diff -p -2 -r1.6 Makefile.in
*** Makefile.in    2000/05/31 15:19:47 1.6
--- Makefile.in    2001/02/20 04:40:44
*************** cygwin-api-int.sgml : cygwin-api.in.sgml
*** 94,101 ****
  
  %.html: %.texinfo
!  -$(TEXI2HTML) -I$(srcdir) $<
  
  readme.txt: $(srcdir)/readme.texinfo $(srcdir)/*.texinfo
!  -$(MAKEINFO) -I$(srcdir) --no-split --no-headers $< -o - |\
   sed '/^Concept Index/,$$d' > $@
  
--- 94,101 ----
  
  %.html: %.texinfo
!  -$(TEXI2HTML) -I=$(srcdir) $<
  
  readme.txt: $(srcdir)/readme.texinfo $(srcdir)/*.texinfo
!  -$(MAKEINFO) -I $(srcdir) --no-split --no-headers $< -o - |\
   sed '/^Concept Index/,$$d' > $@
  
*************** faq.html: $(srcdir)/faq.texinfo $(srcdir
*** 104,108 ****
       sed < $$i -e 's?@file{\([fth]*p://[^}]*\)}?@strong{<A HREF="\1">\1</A>}?' \
       -e 's?\([.+a-zA-Z0-9-]*@@[.a-zA-Z0-9-]*[a-zA-Z0-9]\)?<A 
HREF=" mailto:\1 ">\1</A>?' >./`basename $$i` ; done; \
!  $(TEXI2HTML) -split_chapter  -v ./faq.texinfo; \
   rm -f *.texinfo; \
   cp faq_toc.html faq.html
--- 104,108 ----
       sed < $$i -e 's?@file{\([fth]*p://[^}]*\)}?@strong{<A HREF="\1">\1</A>}?' \
       -e 's?\([.+a-zA-Z0-9-]*@@[.a-zA-Z0-9-]*[a-zA-Z0-9]\)?<A 
HREF=" mailto:\1 ">\1</A>?' >./`basename $$i` ; done; \
!  $(TEXI2HTML) -split=chapter  -v ./faq.texinfo; \
   rm -f *.texinfo; \
   cp faq_toc.html faq.html


