Return-Path: <cygwin-patches-return-3724-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30455 invoked by alias); 20 Mar 2003 00:11:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30397 invoked from network); 20 Mar 2003 00:11:29 -0000
Date: Thu, 20 Mar 2003 00:11:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Remove wrapper functions in pthread.cc
Message-ID: <20030320010110.U29732-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=0.0 required=5.0
	tests=none
	version=2.50
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-SW-Source: 2003-q1/txt/msg00373.txt.bz2


I see this patch removes one unnecessary function call. I think we might be
able to remove one more function call from pthread_* functions to pthread::*
functions. I think it could be possible using GCC's feature of emitting aliases
of functions. This has unfortunately an inconvenience, one needs to have a
mangled C++ function name to be able to define the alias properly. I tryed this
simple test but haven't investigated it more thoroughly.

Vaclav Haisman


#include <cstdio>

void f ()
{
  printf ("f()\n");
}

void g () __attribute__ ((alias ("_Z1fv")));

class A {
public:
  static int static_func (int);
};

int A::static_func (int x)
{
  printf ("A::static_func()");
  return 1;
}

extern "C" int global_func (int) __attribute__ ((alias
("_ZN1A11static_funcEi")));

int main ()
{
  g ();
  global_func (1);
}
