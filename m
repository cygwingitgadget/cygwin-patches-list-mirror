Return-Path: <cygwin-patches-return-3618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30059 invoked by alias); 22 Feb 2003 19:34:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30050 invoked from network); 22 Feb 2003 19:34:58 -0000
Date: Sat, 22 Feb 2003 19:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: syslog
Message-ID: <20030222193516.GB10871@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00267.txt.bz2

On Fri, Feb 21, 2003 at 11:32:51PM -0500, Pierre A. Humblet wrote:
>2003-02-22  Pierre Humblet  <pierre.humblet@ieee.org>
>
>	* syslog.cc (syslog): Do not print the Windows pid. Print the Cygwin
>	pid as an unsigned decimal. On Win95 print a timestamp and attempt
>	to lock the file up to four times in 3 ms. 

Applied with one minor change.  I shortened "Cygwin PID = %u" to just "PID %u"

cgf
