Return-Path: <cygwin-patches-return-5994-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9601 invoked by alias); 14 Nov 2006 10:03:11 -0000
Received: (qmail 9570 invoked by uid 22791); 14 Nov 2006 10:03:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 14 Nov 2006 10:03:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id AE5B1544001; Tue, 14 Nov 2006 11:02:58 +0100 (CET)
Date: Tue, 14 Nov 2006 10:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to mapping up to 128 SCSI Disk Devices
Message-ID: <20061114100258.GA31134@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E05F1FD208D5AA45B78B3983479ECF08E436C5@saturn.p3corpnet.pivot3.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E05F1FD208D5AA45B78B3983479ECF08E436C5@saturn.p3corpnet.pivot3.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00012.txt.bz2

On Nov 13 16:42, Loh, Joe wrote:
> 
> This is a modified patch for up to 128 SCSI Disk Devices as discussed in
> http://cygwin.com/ml/cygwin/2006-11/msg00060.html.
> 
> As suggested by Eric Blake, we have snail mailed the copyright
> assignment to Rose Naftaly.

This will take a couple of days, probably.  In the meantime...

> Index: devices.h
> ===================================================================

I must admit that I don't quite understand why that happens, but
when I save your patch into a file, all '=' characters are converted
into a '=3D' sequence.  This is a bit weird given that you're using
us-ascii encoding.  Does anybody know why this happens?

> +++ devices.in  13 Nov 2006 22:30:44 -0000
> @@ -85,7 +85,15 @@
>  "/dev/scd%(0-15)d", BRACK(FHDEV(DEV_CDROM_MAJOR, {$1})),
> "\\Device\\CdRom{$1}"
>  "/dev/sr%(0-15)d", BRACK(FHDEV(DEV_CDROM_MAJOR, {$1})),
> "\\Device\\CdRom{$1}"
>  "/dev/sd%{a-z}s", BRACK(FH_SD{uc $1}), "\\Device\\Harddisk{ord($1) -
> ord('a')}\\Partition0"
> +"/dev/sda%{a-z}s", BRACK(FH_SDA{uc $1}), "\\Device\\Harddisk{26 +
> ord($1) - ord('a')}\\Partition0"
> +"/dev/sdb%{a-z}s", BRACK(FH_SDB{uc $1}), "\\Device\\Harddisk{52 +
> ord($1) - ord('a')}\\Partition0"
> +"/dev/sdc%{a-z}s", BRACK(FH_SDC{uc $1}), "\\Device\\Harddisk{78 +
> ord($1) - ord('a')}\\Partition0"
> +"/dev/sdd%{a-x}s", BRACK(FH_SDD{uc $1}), "\\Device\\Harddisk{104 +
> ord($1) - ord('a')}\\Partition0"
> [...]

The patch is also broken due to unexpected line breaks, see above.

> +  else if (drive < 112)          // /dev/sdcs -to- /dev/sddh
> +    {
> +      base = DEV_SD6_MAJOR;
> +      drive -= 96;
> +    }
> +  // NOTE: This will cause multiple /dev/sddx entries in
> +  //       /proc/partitions if there are more than 128 devices

Any problem to fix that and to get rid of this comment?  If not,
can you please convert the comment to C-style /**/?


Thanks for the patch.  We have to wait for Rose now, though.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
