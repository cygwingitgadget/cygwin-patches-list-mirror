Return-Path: <cygwin-patches-return-5164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13486 invoked by alias); 22 Nov 2004 18:46:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13165 invoked from network); 22 Nov 2004 18:45:53 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 22 Nov 2004 18:45:53 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 97D7F1B3E5; Mon, 22 Nov 2004 13:46:36 -0500 (EST)
Date: Mon, 22 Nov 2004 18:46:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041122184636.GI32063@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <Pine.GSO.4.61.0411221240590.20353@slinky.cs.nyu.edu> <20041122181301.GD32063@trixie.casa.cgf.cx> <Pine.GSO.4.61.0411221317140.20353@slinky.cs.nyu.edu> <20041122183320.GE32063@trixie.casa.cgf.cx> <Pine.GSO.4.61.0411221333320.20353@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411221333320.20353@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00165.txt.bz2

On Mon, Nov 22, 2004 at 01:36:45PM -0500, Igor Pechtchanski wrote:
>On Mon, 22 Nov 2004, Christopher Faylor wrote:
>>*I've also added an 'exitcode' field to _pinfo so that a Cygwin process
>>*will set the error (sic) code in a UNIX fashion based on whether it is
>>*exiting *due to a signal or with a normal exit().
>>
>>Since a windows program can't exit "due to a signal" the only
>>alternative would be to consider it an exit code.
>
>And what I was trying to say (perhaps not as eloquently as I would have
>wished) was that it's better, IMO, to mangle the negative exit code
>from a Windows app than to let it tread on the reserved bits.

You probably want to mediate on what would possibly be meant by the term
"unix fashion".  Hint: It does not mean "set some reserved bits and do
strange things with negative exit values".  Maybe looking at wait.h
would be helpful.

cgf
