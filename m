Return-Path: <cygwin-patches-return-1521-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 4561 invoked by alias); 27 Nov 2001 09:16:32 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 4520 invoked from network); 27 Nov 2001 09:16:27 -0000
Message-ID: <3C0359E8.818982A1@syntrex.com>
Date: Mon, 15 Oct 2001 19:54:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
 	cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a 
 header
References: <NCBBIHCHBLCMLBLOBONKKEJHCHAA.g.r.vansickle@worldnet.att.net> <3C035977.BF151D0A@syntrex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00053.txt.bz2

Pavel Tsekov wrote:
> 
> "Gary R. Van Sickle" wrote:
> >
> 

Argh... Please, ignore the lines below :(

> And add a break here:
> 
>         if (_strnicmp (l, "Content-Length:", 15) == 0)
>  +        {
>  +          sscanf (l, "%*s %d", &file_size);
>  +          break;
>  +        }
>
