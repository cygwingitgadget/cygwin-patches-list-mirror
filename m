Return-Path: <cygwin-patches-return-4226-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21022 invoked by alias); 17 Sep 2003 21:47:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21012 invoked from network); 17 Sep 2003 21:47:10 -0000
Date: Wed, 17 Sep 2003 21:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: gethostid and GetDiskFreeSpaceEx on NT4
Message-ID: <20030917214705.GA24517@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0309161447260.685@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309161447260.685@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00242.txt.bz2

On Tue, Sep 16, 2003 at 02:58:54PM -0500, Brian Ford wrote:
>The attached patch fixes the Cygwin testsuite failure I mentioned here:
>
>http://www.cygwin.com/ml/cygwin-developers/2003-09/msg00019.html
>
>2003-09-16  Brian Ford <ford@vss.fsi.com>
>
>	* syscalls.cc (gethostid): GetDiskFreeSpaceEx call on NT4
>	requires lpFreeBytesAvailable argument.

Applied.

Thanks.
cgf
