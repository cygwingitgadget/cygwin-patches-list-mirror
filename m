From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@sources.redhat.com>
Subject: Re: testsuite
Date: Mon, 04 Sep 2000 10:00:00 -0000
Message-id: <190254616789.20000904205915@logos-m.ru>
References: <13091183334.20000902233519@logos-m.ru> <20000903001332.A14699@cygnus.com> <110160265820.20000903184643@logos-m.ru> <39B3AF2F.28A64A69@vinschen.de> <98245811598.20000904183229@logos-m.ru> <39B3B6C7.171EFA6@vinschen.de>
X-SW-Source: 2000-q3/msg00060.html

Hi!

Monday, 04 September, 2000 Corinna Vinschen corinna@vinschen.de wrote:

CV> Egor Duda wrote:
>> Monday, 04 September, 2000 Corinna Vinschen corinna@vinschen.de wrote:
>> CV> Did anybody see that building testsuite/liblpt.a from top level dir
>> CV> fails since the include path to winsup/testsuite/liblpt/include isn't
>> CV> propagated then?
>> 
>> CV> Building in testsuite dir itself works.
>> 
>> you mean calling "make testsuite/libltp.a" from winsup/ directory?
>> 
>> i don't know why anybody would need that, but anyway, adding

CV> It's not a question of need. testsuite is build automatically for
CV> example if you start a configure/make from the top level dir. This
CV> isn't winsup but it's ../.. of that (in the build tree).

CV> Corinna

>> testsuite/%:
>>         @$(MAKE) -C testsuite ${patsubst testsuite/%,%,$@}

CV> Can you send that as patch, please?

oops,  i  was  wrong.  i  duplicated  problem and this patch solve the
problem for me.

2000-09-04 Egor Duda <deo@logos-m.ru>

        *  Makefile.in: Always add libltp headers directory to headers
        search path.

Index: winsup/testsuite/Makefile.in
===================================================================
RCS file: /home/duda_admin/cvs-mirror/src/winsup/testsuite/Makefile.in,v
retrieving revision 1.1
diff -u -r1.1 Makefile.in
--- winsup/testsuite/Makefile.in        2000/09/03 03:58:16     1.1
+++ winsup/testsuite/Makefile.in        2000/09/04 16:00:06
@@ -50,7 +50,11 @@
 CC:=@CC@
 # FIXME: Which is it, CC or CC_FOR_TARGET?
 CC_FOR_TARGET:=$(CC)
-CFLAGS:=@CFLAGS@ -MD -Wno-write-strings $(TESTSUP_INCLUDES)
+ifneq (,$(CFLAGS))
+  override CFLAGS+= -MD $(TESTSUP_INCLUDES)
+else
+  CFLAGS:=@CFLAGS@ -MD $(TESTSUP_INCLUDES)
+endif
 CXXFLAGS:=@CXXFLAGS@
 
 AR:=@AR@

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

