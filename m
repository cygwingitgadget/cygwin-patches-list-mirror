Return-Path: <cygwin-patches-return-4392-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23356 invoked by alias); 14 Nov 2003 23:53:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23343 invoked from network); 14 Nov 2003 23:53:22 -0000
Message-ID: <3FB56B10.3020108@cygwin.com>
Date: Fri, 14 Nov 2003 23:53:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: For masochists: the leap o faith
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com> <20031114220708.GA26100@redhat.com>
In-Reply-To: <20031114220708.GA26100@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00111.txt.bz2

Christopher Faylor wrote:

> For the record, I don't have any problems with changing PATH_MAX to
> CYG_PATH_MAX as a first step for this change.  Small steps are, as
> always, appreciated.

Ok, so thats done.

What about, for a next step, simply the introduction of the thunk layer 
- with only A calls used by it. No Unicode, no length changes. ?

Thats probably the most verbose change, with the least variety in 
approach. From there on in we can debate the relative merits of 
path_conv state versus IOThunkState and the like without a huge patch in 
the wings.

Rob
