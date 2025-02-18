Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EB5F73858D20; Tue, 18 Feb 2025 21:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EB5F73858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739913572;
	bh=lE2eQzp66660kU8MqP3wPspjyVviQmDZdDvh+JuX9DQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KQG4jJv3QNZwPDFaGLTP79l4MrL54BBpkYcF8jR+HdvLNoUpFs7IPBRy0yQGL9Y8Q
	 pM20oLRKR5Xp57yFKgtDUuCM1LOZ74VqPpiYvCAmAkGG5My7T8I6TlXIOge5CzxObS
	 r//U3GXVmrHIU9UGhwBLgwLttlHFNsemA9qC8a9o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C3CC8A817D2; Tue, 18 Feb 2025 22:17:46 +0100 (CET)
Date: Tue, 18 Feb 2025 22:17:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <Z7T4-niDlDcaaf9E@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com>
 <Z7TsohGAWwR9nOhX@calimero.vinschen.de>
 <e2c71487-2b97-e74d-0683-962f41decab6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2c71487-2b97-e74d-0683-962f41decab6@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 18 13:10, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 18 Feb 2025, Corinna Vinschen wrote:
> 
> > Actually, given that we can't do without GetLogicalDrives anyway,
> > this could be folded into the mapping list creation within
> > dos_drive_mappings::dos_drive_mappings.
> 
> I don't agree.  That would affect the other user(s) of dos_drive_mappings.
> What if somebody had a mapped file on a file on a floppy drive and looked
> in /proc/<PID>/maps?

Good point.  Bad enough we still have to care for floppies.


Corinna
