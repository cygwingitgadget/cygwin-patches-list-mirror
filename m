From: Brian Keener <bkeener@thesoftwaresource.com>
To: Trevor Forbes <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Thu, 08 Mar 2001 13:54:00 -0000
Message-id: <VA.0000069b.012559b5@thesoftwaresource.com>
References: <004f01c0a80f$88e94a60$0200a8c0@voyager>
X-SW-Source: 2001-q1/msg00159.html

Trevor Forbes wrote:
> ----- Original Message ----- 
> From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
> > 
> > I would like to see the ability of setup to download all sources,
> > even the packages which don't need updating. I can't see a reason
> > that I'm unable to download the sources 10 minutes after installing
> > only because I forgot to click on the src? button in that moment.
> > 
> > Corinna
> 
> Ditto
> 
> Trevor
>
This is exactly what I was about to ask you.  If you are doing the 
download from internet and then the install from local directory then you 
are doing it exactly as I normally do.  Are you saying that when you 
select download from internet and first see the choose screen and the 
packages needing updating (which defaulted to current) are displayed that 
there is no option to check the box for downloading the source.  This 
works for me as does the install from local directory.  

Again bear in mind if you have not downloaded the source at download time 
then you will not see the option to install the sources when you install 
from local directory.  On the same note if you download the binary and 
install the binary then you will not see the package under partial but 
you will under full -- but you will not be presented with the option to 
redownload or reinstall the installed package and because the package is 
installed you will not be given the option to download the source which 
is what Corinna's message pertains to and I must admit I agree with and 
contemplated doing before and may now for sure.

I am seeking clarification as to where your setup diverts from this 
expected operation.

I know I *sound* *like* I am defending my changes and stating I couldn't 
have made a mistake, but that is really not the case.  My C++ programming 
abilities are extremely thin and this is really a learning tool for me so 
I really do want to know if there is a problem and get it fixed or roll 
back the changes - whatever is required.  I would prefer to solve since I 
felt the changes I made were an enhancement but this is a group project 
so if I goofed it up from what everyone would prefer it was still a good 
learn for me.

Bk

