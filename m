Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9AF683858D28; Wed, 27 Nov 2024 15:33:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9AF683858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732721624;
	bh=zUqlX4zGuBLjbHozOpa+yFViVwamczBcJFBAi3CUf/U=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=trpet+P+QNpOY+ND4HCjiEKLUOZXOWRQBI1O/WBFzmk3rqhXVHeaJmcCprpfvBQTK
	 PUA2nPWKq1Zi9K/OgDvvtYy+EYc3ysem2MjB6la+SmAQNYyzv6QX33wfHTnFL/gfna
	 lGDk6g2wqdMsODi6tcJXxUmoIUCQi/cSpc+TFUH4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8C34DA80E4D; Wed, 27 Nov 2024 16:33:42 +0100 (CET)
Date: Wed, 27 Nov 2024 16:33:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <Z0c71iqtu1Zk2vNK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com>
 <Z0XNgZoVQI_P5FMD@calimero.vinschen.de>
 <42819a86-1e9f-6569-a08e-fd719115a2c3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42819a86-1e9f-6569-a08e-fd719115a2c3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 14:27, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 26 Nov 2024, Corinna Vinschen wrote:
> 
> > On Nov 25 11:24, Jeremy Drake via Cygwin-patches wrote:
> > > +      switch (wincap.host_machine ())
> > > +	{
> > > +	  case IMAGE_FILE_MACHINE_AMD64:
> > > +	    n = stpcpy (buf, "-x64") - buf;
> > > +	    break;
> > > +	  case IMAGE_FILE_MACHINE_ARM64:
> > > +	    n = stpcpy (buf, "-ARM64") - buf;
> > > +	    break;
> > > +	  default:
> > > +	    n = __small_sprintf (buf, "-%04y", (int) wincap.host_machine ());
> > > +	    break;
> > > +	}
> >
> 
> > You can greatly simplify this switch.  We don't support 32 bit systems
> > and we will never again support 32 bit systems.  Any combination
> > including a 32 bit system can just go away.  Theoretically, only
> > the IMAGE_FILE_MACHINE_ARM64 case should be left.
> 
> Is the above edit enough, or do I need to remove the x64 case entirely as
> well?  If you truly just want to handle ARM64, this whole function could
> be inlined into just an
> 
>   if (wincap.host_machine () != wincap.cygwin_machine ()
>       && wincap.host_machine () == IMAGE_FILE_MACHINE_ARM64)
>     strcat (name->sysname, "-ARM64");
> 
> For a little more future-proofing, nested if/else so non-ARM64 gets the
> hex fallback from the default case above.

I'm not opposed to a switch statement consisting of an
IMAGE_FILE_MACHINE_ARM64 case and a default case adding "-???" or
something.  Chances are so extremly slim that we'll ever see another
CPU emulated on x86_64, we can always add a case for that if it turns
out that I'm totally wrong, right?


Thanks,
Corinna
