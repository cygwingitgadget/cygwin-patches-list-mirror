Return-Path: <cygwin-patches-return-1510-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 28682 invoked by alias); 21 Nov 2001 04:32:15 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 28668 invoked from network); 21 Nov 2001 04:32:14 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2794@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Mon, 15 Oct 2001 16:36:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2001-q4/txt/msg00042.txt.bz2

Ah.  I see what you mean.  I've always done ifs like that, and never
considered that the braces would be a "thing".  If you or Corinna want, I'll
redo em and resubmit.  15th times the charm...

Mark

> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com] 
> Sent: Tuesday, November 20, 2001 10:35 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
> 
> 
> The code looks good to me, but it seems like you you're using 
> K&R formatting rather than GNU formatting, i.e., the curly 
> braces don't match the rest of the code.
> 
> This is pretty minor, and normally I would just apply the 
> patch, fix the couple of formatting glitches, and check this 
> in, however, since mkpasswd.c is sort of owned by Corinna, 
> I'll let her have final approval.
> 
> Btw, the ChangeLog entry looks fine.
> 
> Thanks for this patch.  I'm looking forward to getting it 
> into the main distribution.
> 
> cgf
