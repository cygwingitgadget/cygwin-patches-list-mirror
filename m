Return-Path: <cygwin-patches-return-2029-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4545 invoked by alias); 9 Apr 2002 02:21:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4531 invoked from network); 9 Apr 2002 02:21:36 -0000
Date: Mon, 08 Apr 2002 19:21:00 -0000
From: Christopher Faylor <cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ip.h & tcp.h
Message-ID: <20020409022132.GB24022@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <001601c1df6a$0d08ea20$0610a8c0@wyw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601c1df6a$0d08ea20$0610a8c0@wyw>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00013.txt.bz2

On Tue, Apr 09, 2002 at 09:56:37AM +0800, Wu Yongwei wrote:
>ChangeLog: BSD-style header files ip.h, tcp.h, and udp.h are added, which
>include definitions for IP, TCP, and UDP packet header structures.

>Positions:
>* ip.h.diff is against /usr/include/netinet/ip.h
>* tcp.h.diff is against /usr/include/netinet/tcp.h
>* udp.h should be added to /usr/include/netinet
>* ip.h in /usr/include/cygwin contains only a comment and I suppose it could
>be dropped.
>
>
>BSD licence:
>1. Redistributions of source code must retain the above copyright
>   notice, this list of conditions and the following disclaimer.
>2. Redistributions in binary form must reproduce the above copyright
>   notice, this list of conditions and the following disclaimer in the
>   documentation and/or other materials provided with the distribution.
>3. All advertising materials mentioning features or use of this software
>   must display the following acknowledgement:
>     This product includes software developed by the University of
>     California, Berkeley and its contributors.
>4. Neither the name of the University nor the names of its contributors
>   may be used to endorse or promote products derived from this software
>   without specific prior written permission.
>
>Best regards,

1) Patches just to cygwin-patches, please.

2) Your ChangeLog is incorrect.

3) Please submit 1 (one) patch for everything rather than one patch per file.
   It just makes a reviewer's life harder if you submit multiple patches as
   attachments.  If your mailer allows you to submit patches inline without
   screwing up spacing that is preferred.

4) The diffs and ChangeLog should make it very obvious what is being changed.
   There is no need for more words at this point.  If this was your first
   submission asking for a change to Cygwin, then, sure, add a description.
   You've already beaten this subject to death, however, so there is no need
   for more justification.

None of the above is a show stopper except for 2.  As I predicted, your
ChangeLog is incorrect.  Go back to the web page that I keep mentioning
to see why.

cgf
