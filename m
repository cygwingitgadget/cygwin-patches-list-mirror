Return-Path: <cygwin-patches-return-4584-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13999 invoked by alias); 3 Mar 2004 09:55:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13990 invoked from network); 3 Mar 2004 09:55:41 -0000
Date: Wed, 03 Mar 2004 09:55:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: Final patch for audio recording with /dev/dsp
Message-ID: <20040303095543.GC1587@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C3FF0F.B9D54520.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C3FF0F.B9D54520.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00074.txt.bz2

[Sorry for the delay, I didn't realize that my mail to cygwin-patches
 didn't come through]

Hi Gerd,

thanks for the patch, but regardless of the content, it's not acceptable
for a few stylistic reasons:

- All sentences end in a full stop in the ChangeLog.

- Could you please change all one line if expressions like this:

    if (head_ == depth1_) head_ = 0;

  to

    if (head_ == depth1_)
      head_ = 0;

- Please change `*(buffer+1)' to `*(buffer + 1)'.

- Please change

    do {
      blah;
    } while (foo);

  to

    do
      {
        blah;
      }
    while (foo);

  This is also written in the first form in other files but those are files
  taken from other sources, not genuine Cygwin files.

- One line comments using C++-comment style (//) are ok, but it would be
  nice, if you could convert multiline comments to this

    /* This is a 
       multiline comment. */

  style.  I know that the surrounding code doesn't always adhere to that
  rule, but I'd not be unhappy if you would change these comments as well.


But the biggest possible favor you could do us is, to send patches in
clear text, not uuencoded or zipped.  Attachments or inline are both ok,
the ChangeLog is inline most welcome.  Clear text patches allow to discuss
issues online easily and one doesn't have to unpack a patch just for being
able to look into it.


Thanks,
Corinna


On Feb 29 22:02, Gerd Spalink wrote:
> Hello,
> 
> Please find attached the patch updated against current CVS.
> It replaces the patch posted on Feb 7, 2003.
> It has been created from the directory src/winsup (paths are relative from there)
> 
> The third attachment is the test that on my system resides in directory
> src/winsup/testsuite/winsup.api
> to make it part of the testsuite. On my system (Win2000, on board AC97 audio),
> it works fine stand-alone and as part of "make check". It takes 16.4 seconds to complete
> and emits some beeping noises on the speakers.
> 
> Best regards
> 
> Gerd

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
