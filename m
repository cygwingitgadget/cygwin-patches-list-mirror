Return-Path: <cygwin-patches-return-1721-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3968 invoked by alias); 17 Jan 2002 00:47:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3954 invoked from network); 17 Jan 2002 00:47:43 -0000
Message-ID: <184201c19ef0$81af1800$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>,
	"'Corinna Vinschen'" <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D2A39@cnmail> <17fa01c19ee6$b9410f80$0200a8c0@lifelesswks>
Subject: Re: fnmatch
Date: Wed, 16 Jan 2002 16:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 17 Jan 2002 00:47:42.0094 (UTC) FILETIME=[91F162E0:01C19EF0]
X-SW-Source: 2002-q1/txt/msg00078.txt.bz2

Just to be clear:

I wanted to get patchutils going, which is why I implemented the two
fn's I did. Total time, about 2.5 hours - probably about the same for
porting and looking up locale stuff etc.

I think it'd be great if Mark can contribute his _already ported_
strptime instead of my partial implementation, and I've no ego involved
in a replacement fnmatch either.

Rob

===
----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>; "'Corinna Vinschen'"
<cygwin-patches@cygwin.com>
Sent: Thursday, January 17, 2002 10:37 AM
Subject: Re: fnmatch


>
> ===
> ----- Original Message -----
> From: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>
> To: "'Corinna Vinschen'" <cygwin-patches@cygwin.com>
> Sent: Thursday, January 17, 2002 10:07 AM
> Subject: RE: fnmatch
>
>
> > Thanks Corinna.  I just ported the openbsd version of strptime over
> > yesterday for utmpdump and had the link for strptime handy.  I
wasn't
> sure
> > how to get locale strings from cygwin, so I ended up removing some
> locale
> > generic stuff and hardcoding English values.  Otherwise, I would've
> offered
> > to pitch in.
>
> Why not just contribute the ported strptime you used?
>
> Rob
>
>
