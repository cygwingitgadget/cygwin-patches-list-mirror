Return-Path: <cygwin-patches-return-4037-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21933 invoked by alias); 5 Aug 2003 03:05:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21923 invoked from network); 5 Aug 2003 03:05:15 -0000
Date: Tue, 05 Aug 2003 03:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] readdir (): Do not set 'errno' if end of dir is encountered
Message-ID: <20030805030514.GA3631@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15875.1060051753@www57.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15875.1060051753@www57.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00053.txt.bz2

On Tue, Aug 05, 2003 at 04:49:13AM +0200, Pavel Tsekov wrote:
>2003-08-05  Pavel Tsekov  <ptsekov@gmx.net>
>
>	* fhandler_disk_file.cc (fhandler_cygdrive::readdir): Do not change
>	'errno' if end of directory condition is encountered as per SUSv2.
>	* fhandler_proc.cc (fhandler_proc::readdir): Ditto.
>	* fhandler_process (fhandler_process::readdir): Ditto.
>	* fhandler_registry (fhandler_registry::readdir): Ditto.

Applied.

Thanks,
cgf
