From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: typo in cygwin/Makefile.in breaks testsuite
Date: Wed, 22 Nov 2000 08:54:00 -0000
Message-id: <20001122115343.A7290@redhat.com>
References: <10530498554.20001122181511@logos-m.ru>
X-SW-Source: 2000-q4/msg00019.html

Sorry.  Applied.

cgf

On Wed, Nov 22, 2000 at 06:15:11PM +0300, Egor Duda wrote:
>Hi!
>
>Index: winsup/cygwin/Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>retrieving revision 1.43
>diff -c -2 -r1.43 Makefile.in
>*** winsup/cygwin/Makefile.in 2000/11/16 20:32:27     1.43
>--- winsup/cygwin/Makefile.in 2000/11/22 15:09:38
>***************
>*** 186,190 ****
>  new-$(LIB_NAME): $(LIB_NAME)
>        $(DLLTOOL) --as=$(AS) --dllname new-$(DLL_NAME) --def $(DEF_FILE) --output-lib new-templib.a
>!       $(AR) rcv new-temp.a $(LIBCOS)
>        mv new-templib.a new-$(LIB_NAME)
>  
>--- 186,190 ----
>  new-$(LIB_NAME): $(LIB_NAME)
>        $(DLLTOOL) --as=$(AS) --dllname new-$(DLL_NAME) --def $(DEF_FILE) --output-lib new-templib.a
>!       $(AR) rcv new-templib.a $(LIBCOS)
>        mv new-templib.a new-$(LIB_NAME)
>  
>
>2000-11-22  Egor Duda <deo@logos-m.ru>
>
>        * Makefile.in: Fix library name.
>
>Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
>

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
