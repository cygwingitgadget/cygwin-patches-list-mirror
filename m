Return-Path: <cygwin-patches-return-3604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2711 invoked by alias); 20 Feb 2003 11:22:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2700 invoked from network); 20 Feb 2003 11:22:31 -0000
Date: Thu, 20 Feb 2003 11:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix testsuite failures with GCC 3.4
Message-ID: <20030220112229.GC2467@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030219235237.V90802-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219235237.V90802-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00253.txt.bz2

On Wed, Feb 19, 2003 at 11:59:11PM +0100, Vaclav Haisman wrote:
> 2003-02-19  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
> 	* winsup.api/crlf.c: Fix C signed/unsigned compare warning.
> 	* winsup.api/mmaptest01.c: Ditto.
> 	* winsup.api/ltp/chmod01.c: Ditto.
> 	* winsup.api/ltp/fork04.c: Ditto.
> 	* winsup.api/ltp/lseek03.c: Ditto.
> 	* winsup.api/ltp/lseek06.c: Ditto.
> 	* winsup.api/ltp/lseek07.c: Ditto.
> 	* winsup.api/ltp/lseek08.c: Ditto.
> 	* winsup.api/ltp/mmap001.c: Ditto.
> 	* winsup.api/ltp/mmap02.c: Ditto.
> 	* winsup.api/ltp/mmap03.c: Ditto.
> 	* winsup.api/ltp/mmap04.c: Ditto.
> 	* winsup.api/ltp/mmap05.c: Ditto.
> 	* winsup.api/ltp/mmap06.c: Ditto.
> 	* winsup.api/ltp/mmap07.c: Ditto.
> 	* winsup.api/ltp/mmap08.c: Ditto.
> 	* winsup.api/ltp/pipe11.c: Ditto.
> 	* winsup.api/ltp/poll01.c: Ditto.
> 	* winsup.api/ltp/sync02.c: Ditto.
> 	* winsup.api/ltp/times03.c: Ditto.
> 	* winsup.api/ltp/umask03.c: Ditto.
> 	* winsup.api/ltp/getpgid01.c: Remove unused obsolete include.
> 	* winsup.api/ltp/getpgid02.c: Ditto.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
