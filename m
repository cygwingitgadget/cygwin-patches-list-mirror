Return-Path: <cygwin-patches-return-3595-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7195 invoked by alias); 19 Feb 2003 01:21:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7182 invoked from network); 19 Feb 2003 01:21:11 -0000
Date: Wed, 19 Feb 2003 01:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030219012118.GC5253@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000701c2d7b3$fbed0e90$78d96f83@pomello> <20030219021346.P54058-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219021346.P54058-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00244.txt.bz2

On Wed, Feb 19, 2003 at 02:19:50AM +0100, Vaclav Haisman wrote:
>On Wed, 19 Feb 2003, Max Bowsher wrote:
>>Well, why not have BitTorrent set the file as sparse?
>
>Because it runs as Cygwin app which is Unix-like environment.  There is
>no way to set files sparse in Unix because all files are sparse if the
>file systems supports it.

...which is, coincidentally enough, why I was interested in the patch.

cgf
