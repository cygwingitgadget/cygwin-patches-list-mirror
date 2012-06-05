Return-Path: <cygwin-patches-return-7666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31486 invoked by alias); 5 Jun 2012 05:20:09 -0000
Received: (qmail 31473 invoked by uid 22791); 5 Jun 2012 05:20:07 -0000
X-SWARE-Spam-Status: No, hits=-5.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_TM
X-Spam-Check-By: sourceware.org
Received: from mail-gh0-f171.google.com (HELO mail-gh0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 05 Jun 2012 05:19:53 +0000
Received: by ghy10 with SMTP id 10so4029632ghy.2        for <cygwin-patches@cygwin.com>; Mon, 04 Jun 2012 22:19:52 -0700 (PDT)
Received: by 10.50.185.163 with SMTP id fd3mr780360igc.22.1338873592175;        Mon, 04 Jun 2012 22:19:52 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id pp4sm874569igb.5.2012.06.04.22.19.50        (version=TLSv1/SSLv3 cipher=OTHER);        Mon, 04 Jun 2012 22:19:51 -0700 (PDT)
Message-ID: <4FCD96F7.4040402@users.sourceforge.net>
Date: Tue, 05 Jun 2012 05:20:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
References: <4FCD945D.8070209@users.sourceforge.net>
In-Reply-To: <4FCD945D.8070209@users.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------040705010202050307000305"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00035.txt.bz2

This is a multi-part message in MIME format.
--------------040705010202050307000305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 336

On 2012-06-05 00:08, Yaakov (Cygwin/X) wrote:
> This patch set implements getmntent_r, a GNU extension:
>
> http://man7.org/linux/man-pages/man3/getmntent.3.html
>
> libvirt needs this[1], as I just (re)discovered. Patches for
> winsup/cygwin and winsup/doc attached.

And here is the code I used to test on Cygwin and Linux.


Yaakov


--------------040705010202050307000305
Content-Type: text/plain; charset=windows-1252;
 name="mntent-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mntent-test.c"
Content-length: 1286

#ifdef CCOD
#pragma CCOD:script no
#endif

#include <mntent.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifdef __CYGWIN__
#include <dlfcn.h>
#include <cygwin/version.h>
#endif

int
main(void)
{
#if defined(__CYGWIN__) && CYGWIN_VERSION_API_MINOR < 262
  void *libc = dlopen ("cygwin1.dll", 0);
  struct mntent *(*getmntent_r) (FILE *, struct mntent *, char *, int)
    = dlsym (libc, "getmntent_r");
#endif

  FILE *mtab = setmntent (_PATH_MOUNTED, "r");
  int buflen = 256;
  char *buf = (char *) malloc (buflen);
  struct mntent mntent, *mntret;
  int i, len;

  while (((mntret = getmntent_r (mtab, &mntent, buf, buflen)) != NULL))
    {
      len = 0;
      for (i = 0; i < 6; i++)
        len += printf ("%s ", buf + len);
      printf ("\n");
      /* check that these are identical with the above */
      printf ("%s %s %s %s %d %d\n", mntent.mnt_fsname, mntent.mnt_dir,
                                     mntent.mnt_type, mntent.mnt_opts,
                                     mntent.mnt_freq, mntent.mnt_passno);
      printf ("%s %s %s %s %d %d\n", mntret->mnt_fsname, mntret->mnt_dir,
                                     mntret->mnt_type, mntret->mnt_opts,
                                     mntret->mnt_freq, mntret->mnt_passno);
    }
  return 0;
}

--------------040705010202050307000305--
