From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@sourceware.cygnus.com
Subject: typo in cygwin/Makefile.in breaks testsuite
Date: Wed, 22 Nov 2000 07:16:00 -0000
Message-id: <10530498554.20001122181511@logos-m.ru>
X-SW-Source: 2000-q4/msg00018.html

Hi!

Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.43
diff -c -2 -r1.43 Makefile.in
*** winsup/cygwin/Makefile.in 2000/11/16 20:32:27     1.43
--- winsup/cygwin/Makefile.in 2000/11/22 15:09:38
***************
*** 186,190 ****
  new-$(LIB_NAME): $(LIB_NAME)
        $(DLLTOOL) --as=$(AS) --dllname new-$(DLL_NAME) --def $(DEF_FILE) --output-lib new-templib.a
!       $(AR) rcv new-temp.a $(LIBCOS)
        mv new-templib.a new-$(LIB_NAME)
  
--- 186,190 ----
  new-$(LIB_NAME): $(LIB_NAME)
        $(DLLTOOL) --as=$(AS) --dllname new-$(DLL_NAME) --def $(DEF_FILE) --output-lib new-templib.a
!       $(AR) rcv new-templib.a $(LIBCOS)
        mv new-templib.a new-$(LIB_NAME)
  

2000-11-22  Egor Duda <deo@logos-m.ru>

        * Makefile.in: Fix library name.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

