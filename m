Return-Path: <cygwin-patches-return-4684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23724 invoked by alias); 13 Apr 2004 20:54:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23662 invoked from network); 13 Apr 2004 20:54:47 -0000
Date: Tue, 13 Apr 2004 20:54:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Last path.cc
Message-ID: <20040413205447.GA9135@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040412192958.0080cab0@incoming.verizon.net> <20040413124306.GD26558@cygbert.vinschen.de> <20040413204913.GG26558@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413204913.GG26558@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00036.txt.bz2

On Tue, Apr 13, 2004 at 10:49:13PM +0200, Corinna Vinschen wrote:
>Oh, one problem left.  Currently fhandler_disk_file::fchmod calls
>chmod_device which is pretty ugly.  Chris, do you have an idea how
>to do that in a cleaner way?

It sounds like the same thing as required by fhandler_base::fstat_fs.

cgf
