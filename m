Return-Path: <cygwin-patches-return-4693-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16594 invoked by alias); 20 Apr 2004 18:45:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16565 invoked from network); 20 Apr 2004 18:45:11 -0000
Date: Tue, 20 Apr 2004 18:45:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: 3 or more initial slashes
Message-ID: <20040420184509.GA24914@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40855FF9.33C9C5DF@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40855FF9.33C9C5DF@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00045.txt.bz2

On Tue, Apr 20, 2004 at 01:38:01PM -0400, Pierre A. Humblet wrote:
>POSIX specifies that three ore more slashes at the beginning
>of a pathname are equivalent to a single one.
>This patch implements that feature. 
>Only Posix paths are affected, Windows paths are left alone. 
>Also, Posix paths are never handled by normalize_win32_path
>anymore.
>
>2004-04-20  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (normalize_posix_path): Process all Posix paths and
>	map three or more initial slashes to a single one. Simplify
>	processing following two initial slashes. 
>	(normalize_win32_path): Make last argument non-optional and
>	do not check for NULL value.

Applied.

Thanks.
cgf
