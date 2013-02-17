Return-Path: <cygwin-patches-return-7804-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23619 invoked by alias); 17 Feb 2013 16:52:07 -0000
Received: (qmail 23584 invoked by uid 22791); 17 Feb 2013 16:52:06 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_DB,TW_XD
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 17 Feb 2013 16:52:00 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U77T6-000F2l-69	for cygwin-patches@cygwin.com; Sun, 17 Feb 2013 16:52:00 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 74B6F880422	for <cygwin-patches@cygwin.com>; Sun, 17 Feb 2013 11:51:59 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19D+vh5WIqZXrvhkyOY5hd+
Date: Sun, 17 Feb 2013 16:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130217165159.GA2177@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130217044622.1034ae22@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130217044622.1034ae22@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00015.txt.bz2

On Sun, Feb 17, 2013 at 04:46:22AM -0600, Yaakov wrote:

>2013-02-16  Yaakov Selkowitz  <yselkowitz@...>
>
>	* Makefile.in (libcygwin.a): Move --target flag from here...
>	(toolopts): to here, to be used by both mkimport and speclib.
>	* speclib: Omit leading underscore in symbol names on x86_64.
>
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>retrieving revision 1.257.2.14
>diff -u -p -r1.257.2.14 Makefile.in
>--- Makefile.in	15 Feb 2013 13:36:35 -0000	1.257.2.14
>+++ Makefile.in	17 Feb 2013 05:15:10 -0000
>@@ -123,7 +123,7 @@ LIBGMON_A:=libgmon.a
> CYGWIN_START:=crt0.o
> GMON_START:=gcrt0.o
> 
>-toolopts:=--ar=${AR} --as=${AS} --nm=${NM} --objcopy=${OBJCOPY} 
>+toolopts:=--target=${target_alias} --ar=${AR} --as=${AS} --nm=${NM} --objcopy=${OBJCOPY}
> speclib=\
>     ${srcdir}/speclib ${toolopts} \
> 	--exclude='cygwin' \
>@@ -434,7 +434,7 @@ $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg 
> 
> # Rule to build libcygwin.a
> $(LIB_NAME): $(LIBCOS) | $(TEST_DLL_NAME) 
>-	${srcdir}/mkimport --target=$(target_alias) ${toolopts} ${NEW_FUNCTIONS} $@ cygdll.a $^
>+	${srcdir}/mkimport ${toolopts} ${NEW_FUNCTIONS} $@ cygdll.a $^
> 
> ${STATIC_LIB_NAME}: mkstatic ${TEST_DLL_NAME}
> 	perl -d $< -x ${EXCLUDE_STATIC_OFILES} --library=${LIBC} --library=${LIBM} --ar=${AR} $@ cygwin.map
>Index: speclib
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/speclib,v
>retrieving revision 1.25
>diff -u -p -r1.25 speclib
>--- speclib	11 Feb 2011 18:00:55 -0000	1.25
>+++ speclib	17 Feb 2013 05:15:10 -0000
>@@ -11,16 +11,17 @@ my $static;
> my $inverse;
> my @exclude;
> 
>-my ($ar, $as, $nm, $objcopy);
>+my ($target, $ar, $as, $nm, $objcopy);
> GetOptions('exclude=s'=>\@exclude, 'static!'=>\$static, 'v!'=>\$inverse,
>-	   'ar=s'=>\$ar, 'as=s'=>\$as,'nm=s'=>\$nm, 'objcopy=s'=>\$objcopy);
>+	   'target=s'=>\$target, 'ar=s'=>\$ar, 'as=s'=>\$as,'nm=s'=>\$nm, 'objcopy=s'=>\$objcopy);
> 
> $_ = File::Spec->rel2abs($_) for @ARGV;
> 
> my $libdll = shift;
> my $lib =  pop;
>+my $uscore = ($target =~ /^x86_64\-/ ? undef : '_');

There is no reason to quote the dash here.  But, I would actually prefer
a substr check since that is a little faster.

my $uscore = (substr($target, 0, 7) eq 'x86_64-') ? ...

cgf
