Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9F76C3858D33; Fri, 17 Nov 2023 16:23:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F76C3858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700238206;
	bh=QYTXWSnvtecKwikz269BMKZAdG2kNlPf9T9xFzgihck=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kO9FWOw1rAnoReCVl++bqABIlBRrQ9iuvB7BHSdKK0ZTKGVdPUE56wnHC6QOnW83v
	 srmZs8I421xISKSGriDrQ7zJHsm/RiqstSXs87uPE1kDJ3xgngzRCGXCpocjxz9mxn
	 fQoMqqeDRhr/iC3YR1TOsQODlU/8TLEygAoL9S9Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C84EBA80BE0; Fri, 17 Nov 2023 17:23:24 +0100 (CET)
Date: Fri, 17 Nov 2023 17:23:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 17 15:39, Christian Franke wrote:
> The last two /dev/disk subdirectories :-)
> 
> Note a minor difference: On Linux, empty /dev/disk subdirectories apparently
> never appear. A subdirectory is not listed in /dev/disk if it would be
> empty. Not worth the effort to emulate.

Agreed.  This is really great.  I just pushed your patch.

However, there's something strange in terms of by-label:

I have two partitions with labels:

  $ ls -l /dev/disk/by-label
  total 0
  lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub -> ../../sda3
  lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub2 -> ../../sdb2
  $

Now I change the label of sdb2 to the same "blub" string as on sda3:

  $ ls -l /dev/disk/by-label
  total 0
  $

I'd expected to see only one, due to the name collision, but en empty
dir is a bit surprising...  And it may occur more often than not, given
that the default label "New_Volume" probably won't get changed very
often.


Thanks,
Corinna
