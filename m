Return-Path: <cygwin-patches-return-2664-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5949 invoked by alias); 19 Jul 2002 08:04:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5932 invoked from network); 19 Jul 2002 08:04:41 -0000
Message-ID: <3D37C874.1131773@certum.pl>
Date: Fri, 19 Jul 2002 01:04:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: /dev/dsp
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00112.txt.bz2

Hi Corinna,

I would like to ask You about /dev/dsp developing. Nicholas Wourms
asked me few days ago about 
implementation of reading from /dev/dsp which is currently unsupported.
Being then not too familiar with this matter I traced current cygwin
sources (fhandler_dsp.cc) and Windows library possibilities. From
Windows point of view it is simple to implement reading from audio
device. Main work is to "convert" it to Cygwin manner. Taking into
account current solution of /dev/dsp in fhandler_dsp.cc for writing it
seems to be not very difficult to implement reading. It of course
requires time for developing so I have questions:

1) Who is really interested - excluding Nicholas :-) - /dev/dsp works in
read mode. It will prevent any possible future work to be useless.

2) Do You know whether the author of /dev/dsp (Andy Younger) or other
people work or are going to work to solve the problem. I can not
guarantee to finish any posiible work from my side 
in predictable moment in time (a lot of work concerned with my job) so
if nobody is going to develop /dev/dsp I could step by step do something
to solve /dev/dsp reading problem.

Jacek
