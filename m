Return-Path: <cygwin-patches-return-1547-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 5788 invoked by alias); 28 Nov 2001 02:27:15 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 5772 invoked from network); 28 Nov 2001 02:27:15 -0000
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream
	as a  header
From: Robert Collins <robert.collins@itdomain.com.au>
To: nhv@cape.com
Cc: cygwin-patches@cygwin.com
In-Reply-To: <004801c177ab$13c9f4c0$a300a8c0@nhv>
References: <004801c177ab$13c9f4c0$a300a8c0@nhv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: Fri, 26 Oct 2001 09:14:00 -0000
Message-Id: <1006914349.637.4.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 28 Nov 2001 02:27:14.0087 (UTC) FILETIME=[30DFB370:01C177B4]
X-SW-Source: 2001-q4/txt/msg00079.txt.bz2

On Wed, 2001-11-28 at 12:21, Norman Vine wrote:
> FWIW
> I believe that Standard C requires NULL to be defined in <stddef.h>
> http://www.ccs.ucsd.edu/c/stddef.html/#NULL

Thanks Norman..

===
NULL

#define NULL <either 0, 0L, or (void *)0> [0 in C++]

The macro yields a null pointer constant that is usable as an address
constant expression.
===

Rob
