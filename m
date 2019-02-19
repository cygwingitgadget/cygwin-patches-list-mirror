Return-Path: <cygwin-patches-return-9199-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53793 invoked by alias); 19 Feb 2019 16:58:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53693 invoked by uid 89); 19 Feb 2019 16:58:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=senior, Senior
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 16:58:06 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 9E11725EEA	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 16:58:05 +0000 (UTC)
Received: from ovpn-116-11.phx2.redhat.com (ovpn-116-11.phx2.redhat.com [10.3.116.11])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 22C22101962A	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 16:58:04 +0000 (UTC)
Message-ID: <a31c3d43c9866900e7938015e2fed2c93712348e.camel@redhat.com>
Subject: Re: [PATCH] Cygwin: add secure_getenv
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Date: Tue, 19 Feb 2019 16:58:00 -0000
In-Reply-To: <20190219115910.GM4256@calimero.vinschen.de>
References: <20190219050950.19116-1-yselkowi@redhat.com>	 <20190219114330.GK4256@calimero.vinschen.de>	 <20190219115910.GM4256@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q1/txt/msg00009.txt.bz2

On Tue, 2019-02-19 at 12:59 +0100, Corinna Vinschen wrote:
> On Feb 19 12:43, Corinna Vinschen wrote:
> > On Feb 18 23:09, Yaakov Selkowitz wrote:
> > > Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> > > ---
> > > This is being used more frequently.  Since we don't have Linux capabilities,
> > > setuid/setgid is the only condition we have to check.
> > 
> > I'm not sure this is right.  The Linux man page claims
> > 
> > "Secure execution is required if one of the following conditions was
> >  true when the program run by the calling process was loaded: [...]"
> > 
> > Do we ever have this situation?  We don't have any capability to make
> > real and effective user ID different at process startup.  But from that
> > description it seems secure_getenv does not trigger secure mode if the
> > process calls seteuid() or setreuid() later in the process.
> > 
> > I ran this STC as root under Linux:
> > 
> > # cat > sec-getenv-test.c <<EOF
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <errno.h>
> > #include <string.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> > 
> > int main ()
> > {
> >   char *env;
> > 
> >   env = secure_getenv ("HOME");
> >   printf ("vor seteuid: HOME=%p <%s>\n", env, env ?: "");
> >   if (seteuid (74) < 0)
> >     printf ("seteuid: %d <%s>\n", errno, strerror (errno));
> >   else
> >     {
> >       env = secure_getenv ("HOME");
> >       printf ("nach seteuid: HOME=%p <%s>\n", env, env ?: "");
> >     }
> >   return 0;
> > }
> > EOF
> > # gcc -g -o sec-getenv-test sec-getenv-test.c
> > # ./sec-getenv-test
> > vor seteuid: HOME=0x7fff17a04ea2 </root>
> > nach seteuid: HOME=0x7fff17a04ea2 </root>
> 
> I also tried to run secure_getenv after fork, like this:
> 
>   seteuid()
>   if (fork () == 0)
>     env = secure_getenv ("HOME");
> 
> but it still returns a valid value.
> 
> So I wonder if secure_getenv isn't just a synonym for getenv
> in our case.

Or could it be the STC?  glibc's test is a bit more complicated:

https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/tst-secure-getenv.c;hb=HEAD

And, looking now, FWIW gnulib's implementation is practically similar:

https://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob;f=lib/secure_getenv.c;hb=HEAD

So if there is something wrong with the patch, then AFAIK gnulib is
wrong too.  Eric?

-- 
Yaakov Selkowitz
Senior Software Engineer - Platform Enablement
Red Hat, Inc.

