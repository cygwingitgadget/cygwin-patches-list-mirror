Return-Path: <cygwin-patches-return-1853-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27023 invoked by alias); 7 Feb 2002 15:05:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26908 invoked from network); 7 Feb 2002 15:05:44 -0000
Date: Sat, 09 Feb 2002 00:35:00 -0000
From: Alexander Gottwald <alexander.gottwald@informatik.tu-chemnitz.de>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Tokenring support for network interfaces
In-Reply-To: <20020207151153.Z14241@cygbert.vinschen.de>
Message-ID: <Pine.LNX.4.21.0202071532110.9517-100000@rotuma.informatik.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q1/txt/msg00210.txt.bz2

On Thu, 7 Feb 2002, Corinna Vinschen wrote:

> Me neither.  Perhaps it's ok to implement it just based on the
> description (if any and if it's at all possible)?!?

For NT and 95: every interface which is not ppp is considered as eth type. 
This is not correct, but at least they're listed. I've searched the msdn
but found no information where and how it is coded that an network inter-
face is tokenring or ethernet or something else.

The Problem with the 2k implementation was that the tokenring adapters
were left out and xfree could not find the correct interface for the local 
ip-address.

bye
	ago
-- 
 Alexander.Gottwald@informatik.tu-chemnitz.de 
 http://www.gotti.org           ICQ: 126018723
 phone: +49 3725 349 80 80	mobile: +49 172 7854017
