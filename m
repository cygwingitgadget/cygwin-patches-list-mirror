Return-Path: <cygwin-patches-return-3468-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28380 invoked by alias); 30 Jan 2003 04:11:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28371 invoked from network); 30 Jan 2003 04:11:26 -0000
Message-ID: <002401c2c815$a7987490$6501a8c0@tcurtiss2>
From: "Troy Curtiss" <tcurtiss@qcpi.com>
To: <cygwin-patches@cygwin.com>
Subject: Re: status? : [PATCH] - tc{set,get}attr() error checking and B0 support 
Date: Thu, 30 Jan 2003 04:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00117.txt.bz2

Chris,
  Have you have a chance to take a look at my latest patch rounding out the
tc{set,get}attr() support for B230400 (and B0)?  I've been beating on it for
a week and it seems to work correctly wrt. serial port operations.  The only
trouble (which was present before my patch) is errno not getting propagated
back up when the tc{set,get}attr() call fails.  Thanks,

-Troy
