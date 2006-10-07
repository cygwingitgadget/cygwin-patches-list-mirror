Return-Path: <cygwin-patches-return-5988-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3335 invoked by alias); 7 Oct 2006 11:44:16 -0000
Received: (qmail 3325 invoked by uid 22791); 7 Oct 2006 11:44:15 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sat, 07 Oct 2006 11:44:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9C3CD544001; Sat,  7 Oct 2006 13:44:08 +0200 (CEST)
Date: Sat, 07 Oct 2006 11:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to enable proper handling of Win32 //?/GLOBALROOT/device paths
Message-ID: <20061007114408.GA4843@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5DE1FE5AC2164C4BB6BA31575FF42CDA0A4C7B@mutable2.home.mutable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DE1FE5AC2164C4BB6BA31575FF42CDA0A4C7B@mutable2.home.mutable.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00006.txt.bz2

On Oct  6 15:32, d3@mutable.net wrote:
> This patch is to enable Win32 device paths in the form of:
> 
> //?/GLOBALROOT/Device/Harddisk0/Partition1/
> //?/GLOBALROOT/Device/Harddiskvolume1/
> //?/GLOBALROOT/Device/HarddiskVolumeShadowCopy1/
> 
> Etc... 
> 
> This patch to cygwin enables tools like rsync to access Win32 volume
> shadow copies that can be created with Win32 tools like vshadow.exe so
> that you can access open files, SQL, and Exchange databases.
> 
> A note about the change in fhandle_disk_file.cc: The patch enforces
> Win32 style paths (i.e. backslashes) because the NT kernal functions do
> not like mixed paths when accessing \\?\GLOBALROOT. They will only
> accept backslashes.
> 
> Here is a rsync test I have been successfully using with this patch
> applied:
> 
> rsync -av --modify-window=2
> //?/globalroot/device/harddiskvolume1/testfiles/ server::test/testfiles/

Sorry, but I have a hard time to see how accessing GLOBALROOT directly
would be good for us.  Usually we don't want Cygwin to make more
concessions related to Windows or NT paths than already necessary.
These paths should rather only be used under the hood and Cygwin is
supposed to provide a POSIXy way to access stuff. 

So, what should the patch accomplish?  Access to harddisks and
partitions is already possible using POSIX paths, access to files or
directories, naturally, too.  One new thing here is that you can access
the whole NT namespace, which is not very useful, unless you allow
qualified access.  This in turn requires fhandlers which know the
devices they are supposed to access, as well as matching POSIX paths.
Raw access to NT devices is not what Cygwin is designed for(*).

The really interesting new thing would be the ability to access volume
shadow copies.  Opening up GLOBALROOT access just to access shadow
copies looks rather wrong to me.  Rather there should be a useful
mapping from the NT paths to POSIX-like paths.  I don't know off-hand
how these paths would look like(**), though.  I assume the
implementation could look very similar to the implementation of the
cygdrive fhandler(***).


Corinna


(*) Though in the long run it could be funny to allow something similar
    to generic SCSI access (/dev/sgX).  For instance, the /Device directory
    in the NT namespace could be mapped to /dev/nt/ or something.

(**) Is there some shadow copy concept in the POSIX world somewhere?  Does
    anybody know about this and how device names are constructed for this
    access?

(***) Please don't forget to sign and send the copyright assignment form
    when providing longer patches.  See http://cygwin.com/contrib.html

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
