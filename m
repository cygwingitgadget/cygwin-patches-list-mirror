From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [Patch] setup.exe - change to not ask root on download only.
Date: Wed, 14 Nov 2001 11:41:00 -0000
Message-ID: <VA.000009dc.00a69973@thesoftwaresource.com>
References: <VA.000009d7.011e66c9@thesoftwaresource.com> <01ee01c16c9e$0350bce0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00223.html
Message-ID: <20011114114100.1tobFd25sj2X-cZqgsn__jmnExkkjw4nfAvtr5_ZLVI@z>

Robert Collins wrote:
> can you generate patches with "-up" ? (See the cygwin contributors
> page).
> It makes it a lot easier to visually grok a patch.

I can do that.  Actually I knew I had done it two ways in the past and couldn't 
remember the other.  Nor was I sure which was the preferred - now I know.

> I'll update this for you to the io_streams code for HEAD committing.

Did it make it in the version you just rolled to the web page.

> Lastly, you were missing a call to get_root_dir_now which resulted in
> /etc/setup/last-cache never getting read.

Hum,  I'll have to look at the change you made - I thought mine was reading 
either file depending on where it found it. Ah well.  Thanks for correcting it 
anyways.



