Return-Path: <cygwin-patches-return-5720-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25175 invoked by alias); 25 Jan 2006 10:52:45 -0000
Received: (qmail 25163 invoked by uid 22791); 25 Jan 2006 10:52:44 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 25 Jan 2006 10:52:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D0190544001; Wed, 25 Jan 2006 11:52:40 +0100 (CET)
Date: Wed, 25 Jan 2006 10:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
Message-ID: <20060125105240.GM8318@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43D6876F.9080608@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D6876F.9080608@t-online.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00029.txt.bz2

On Jan 24 21:00, Christian Franke wrote:
> Hi,
> 
> the attached patch adds commands "load" and "unload" and options "-b, 
> --binary" to regtool.
> 
> Load a registry hive from PATH into new SUBKEY:
> 
> regtool load KEY\SUBKEY PATH
> 
> Unload and remove SUBKEY later:
> 
> regtool unload KEY\SUBKEY
> 
> Print REG_BINARY value as hex:
> 
> regtool -b get KEY\VALUE
> 
> Set REG_BINARY value from hex args:
> 
> regtool -b set KEY\VALUE XX XX XX XX ...
> 
> 
> Example:
> Suppose S:\ is a partition on a second HD which contains a copy of all 
> files of XP system partition C:\.
> The following script fixes the logical drive mappings of the backup 
> installation.
> This allows booting backup drive S:\ as C:\ after original C:\ drive has 
> been removed.
> 
> #!/bin/sh
> set -e
> 
> # Load backup SYSTEM hive as SYSTEM.TMP
> regtool load /HKLM/SYSTEM.TMP /cygdrive/s/WINDOWS/system32/config/system
> trap 'regtool unload /HKLM/SYSTEM.TMP' ERR
> 
> # Remove all logical drive mappings in backup
> # (Somewhat tricky, because key value names contain backslashes)
> for v in $(regtool list /HKLM/SYSTEM.TMP/MountedDevices |
>          sed -n '/^\\DosDevices\\[C-Z]:$/s,\\,/,gp')
> do
>  regtool -K, unset "/HKLM/SYSTEM.TMP/MountedDevices,$v"
> done
> 
> # Map current S:\ as C:\ in backup
> m=$(regtool -K, -b get /HKLM/SYSTEM/MountedDevices/,/DosDevices/S:)
> regtool -K, -b set /HKLM/SYSTEM.TMP/MountedDevices/,/DosDevices/C: $m
> 
> # Unload hive
> trap '' ERR
> regtool unload /HKLM/SYSTEM.TMP
> 
> # End of script
> ####################
> 
> 
> Thanks for any comment

Thanks for this patch, it looks pretty useful.  There are just two
things missing.  First, could you please create a matching ChangeLog
entry?  Second, worse, I don't see your name on the list of people
having a copyright assignment in place, which is definitely necessary
for a patch of this size.  We need a written copyright assignment from
you once, after that, you can create as many patches as you like.
Please see http://cygwin.com/contrib.html for the gory details about
the copyright assignment form and how to send it to Red Hat.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
