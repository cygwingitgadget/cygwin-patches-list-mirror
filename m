Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ABE814B9DB75; Sat, 14 Feb 2026 09:58:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ABE814B9DB75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1771063125;
	bh=ZuUs+dzIJ5+/xZrqHWbyfHNUsRffjTFHNbM98+Rx6yE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tfl3vlXHn4VIKwl3xjmg0bo1BM+xjse4EmgG2nqWV6LeA++eCBLpGyG2uxwYLtV2f
	 6HmGEZ83OlXYY+hMYfBWEWOTeG12EZKbyx5W00UTG6rrb0hyyaIP2DZSNiMeHkWIUU
	 bB3GN2SeMq5NqqFCtqfOXVnAocDXPdADPWosVIzE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3E1DBA80CBB; Sat, 14 Feb 2026 10:58:43 +0100 (CET)
Date: Sat, 14 Feb 2026 10:58:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Thomas Wolff <towo@towo.net>
Subject: Re: [PATCH 3/3] Cygwin: improve PCA workaround
Message-ID: <aZBHUzq6ttMgLEgT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Thomas Wolff <towo@towo.net>
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <20260126111345.386303-4-corinna-cygwin@cygwin.com>
 <b081744f-c953-4ca2-bdc9-fdd260acb494@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b081744f-c953-4ca2-bdc9-fdd260acb494@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>


[CCing Thomas]

On Feb 13 17:36, Brian Inglis wrote:
> On 2026-01-26 04:13, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> 
> > Perform the check only if we're the root process of a Cygwin process
> > tree.  If we start mintty from Cygwin, the PCA trigger doesn't occur.
> 
> > diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> > index 1d5a452b4fbc..e080aa41bca2 100644
> > --- a/winsup/cygwin/dcrt0.cc
> > +++ b/winsup/cygwin/dcrt0.cc
> > @@ -253,6 +253,17 @@ frok::parent (volatile char * volatile stack_here)
> >        systems. */
> >     c_flags |= CREATE_UNICODE_ENVIRONMENT;
> > +  /* Despite all our executables having a valid manifest, "mintty" still
> > +     triggers the "Program Compatibility Assistant (PCA) Service" for
> > +     some reason, maybe due to some heuristics in PCA.
> All makes sense and looks reasonable to a non-Windows type!
> 
> There are no differences between the windows or either mingw64 default
> manifests, but mintty has extra, after tweaking its order and layout to
> match, so perhaps something there needs updated in GH:
> 
> $ diff res.mft default-manifest.mft
> --- res.mft	2026-02-13 17:21:21.491931500 -0700
> +++ default-manifest.mft	2026-02-13 17:18:08.759527200 -0700
> @@ -3,40 +3,22 @@
>    <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
>      <security>
>        <requestedPrivileges>
> -        <requestedExecutionLevel level="asInvoker" uiAccess="false"/>
> +        <requestedExecutionLevel level="asInvoker"/>
>        </requestedPrivileges>
>      </security>
>    </trustInfo>
> --
> -  <dependency>
> -    <dependentAssembly>
> -      <assemblyIdentity
> -        type="win32"
> -        name="Microsoft.Windows.Common-Controls"
> -        version="6.0.0.0"
> -        publicKeyToken="6595b64144ccf1df"
> -        language="*"
> -        processorArchitecture="*"
> -      />
> -    </dependentAssembly>
> -  </dependency>
> -  <asmv3:application xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">
> -    <asmv3:windowsSettings>
> -      <dpiAware
> xmlns="http://schemas.microsoft.com/SMI/2005/WindowsSettings">true</dpiAware>
> -      <dpiAwareness xmlns="http://schemas.microsoft.com/SMI/2016/WindowsSettings">PerMonitorV2</dpiAwareness>
> -    </asmv3:windowsSettings>
> -  </asmv3:application>
>  </assembly>

But the mintty manifest looks correct. Compared to the default mainfest,
it just tells the OS that it's a GUI process and that it's DPI aware.

Maybe the older dpiAware could be set to "true/pm", but I can't judge
that, actually.

The rest of the manifest claims compatibility with all Windows versions
since Vista up to Windows 10/11, as usual.  So it's no surprise that
task manager prints no downgraded OS compatibility context for mintty.

But then again, why on earth is mintty running in PCA job at all?!?

iIt would be great if we could get rid of this code in Cygwin.

OTOH, what keeps the PCA heuristics to change the rules with every
OS release?

> Cygwin seems to have no mintty repos available!
> Perhaps GH mintty/mintty should be mirrored on sourceware?

All but a few projects in the distro are not on sware.  As long as
it's OSS and the sources can be found on a public repo, all is well,
isn't it?


Thanks,
Corinna
