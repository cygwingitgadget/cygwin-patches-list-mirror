Return-Path: <cygwin-patches-return-3707-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15996 invoked by alias); 14 Mar 2003 22:47:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15918 invoked from network); 14 Mar 2003 22:47:14 -0000
Message-ID: <021401c2ea7b$a663f1c0$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>,
	"Bob Cassels" <bcassels@abinitio.com>
References: <OF5F37C502.04A60CCA-ON85256CE9.006C05FA-85256CE9.006CA1A3@abinitio.com>
Subject: Re: [PATCH]: (newlib) Allow wcschr(x, L'\0')
Date: Fri, 14 Mar 2003 22:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00356.txt.bz2

Bob Cassels wrote:
> This simple patch for newlib allows using wcschr to find pointers to
                    ^^^^^^^^^^
Newlib has its own mailing list: See http://sources.redhat.com/newlib/

> null characters, rather than returning NULL.  I hope it's simple
> enough to not require paperwork.

Max.
