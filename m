From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [psusi@cfl.rr.com: Bug report in installer]
Date: Mon, 09 Jul 2001 07:35:00 -0000
Message-id: <20010709103525.B19635@redhat.com>
References: <20010708165111.B16986@redhat.com> <177327937358.20010709102708@logos-m.ru> <68329971954.20010709110103@logos-m.ru>
X-SW-Source: 2001-q3/msg00004.html

Check it in, please, Egor?

Thanks,
cgf

On Mon, Jul 09, 2001 at 11:01:03AM +0400, egor duda wrote:
>Hi!
>
>Monday, 09 July, 2001 egor duda deo@logos-m.ru wrote:
>
>ed> Hi!
>
>ed> Monday, 09 July, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF>> Didn't we fix this some time ago?
>
>ed> I've submitted a patch for this, but it apparently wasn't applied.
>ed> i'll remake it against current sources and resubmit it.
>
>Uhm, i should have looked before posting this. it was applied, but the
>problem is with foreground. not background. here's the patch.
>
>CF>> ----- Forwarded message from Phillip Susi <psusi@cfl.rr.com> -----
>CF>> From: Phillip Susi <psusi@cfl.rr.com>
>CF>> To: cygwin@cygwin.com
>CF>> Subject: Bug report in installer
>CF>> Date: Sun, 08 Jul 2001 14:05:28 -0400
>
>CF>> Hi, I just installed the latest cygwin from the web site, and there is a 
>CF>> bug in the installer UI:
>
>CF>> When you select which components to install, it draws the names of the 
>CF>> components in black text, assuming the user's background color is 
>CF>> white.  My color scheme is white text on a black background, and so the 
>CF>> installer used the black background, with the black text, so I couldn't see 
>CF>> it.  When drawing text, you should use the windows color scheme foreground 
>CF>> text color, not force it to be black.
>
>CF>>    -->Phillip Susi
>CF>>       psusi@cfl.rr.com
>CF>> ----- End forwarded message -----
>
>Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
