Return-Path: <cygwin-patches-return-4227-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23495 invoked by alias); 20 Sep 2003 09:14:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23486 invoked from network); 20 Sep 2003 09:14:05 -0000
From: =?koi8-r?Q?=22?=Artem Khodush=?koi8-r?Q?=22=20?=<greenkaa@mail.ru>
To: cygwin-patches@cygwin.com
Subject: O_NONBLOCK for pipes
Mime-Version: 1.0
X-Originating-IP: [212.248.122.13]
Date: Sat, 20 Sep 2003 09:14:00 -0000
Reply-To: =?koi8-r?Q?=22?=Artem Khodush=?koi8-r?Q?=22=20?=<greenkaa@mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-Id: <E1A0doP-0008SO-00.greenkaa-mail-ru@f23.mail.ru>
X-SW-Source: 2003-q3/txt/msg00243.txt.bz2

Hello!

I have straightforward patch,
containing about 20 lines of new code,
which implements O_NONBLOCK fcntl for pipes
using SetNamedPipeHandleState NT API call.

Two questions before I send it:

Will it be considered trivial, 
so that copyright assignement is not required?

Is there some deep reason, which I don't see,
why this was not implemented before?
