Return-Path: <cygwin-patches-return-6537-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5988 invoked by alias); 4 Jun 2009 02:51:24 -0000
Received: (qmail 5978 invoked by uid 22791); 4 Jun 2009 02:51:23 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0 	tests=AWL,BAYES_50,J_CHICKENPOX_74,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 02:51:14 +0000
Received: by bwz26 with SMTP id 26so442561bwz.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 19:51:11 -0700 (PDT)
Received: by 10.103.172.7 with SMTP id z7mr1017347muo.15.1244083871325;         Wed, 03 Jun 2009 19:51:11 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id e9sm2450942muf.32.2009.06.03.19.51.10         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 19:51:10 -0700 (PDT)
Message-ID: <4A273967.6090703@gmail.com>
Date: Thu, 04 Jun 2009 02:51:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 3
References: <4A270656.8090704@gmail.com> <4A270BA4.3080602@gmail.com> <20090604014145.GB15999@ednor.casa.cgf.cx>
In-Reply-To: <20090604014145.GB15999@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------030706030600060909090007"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00079.txt.bz2

This is a multi-part message in MIME format.
--------------030706030600060909090007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1533

Christopher Faylor wrote:

> I thought that, given your last message to cygwin-developers, you were
> going to go off and figure out the best of four implementations.  Is this
> the result of that investigation?

  Once I discarded the ones that weren't quite right because they included a
setz/sete instruction (bsd and boehm), I was left with the ones in the
attached testcase.  The only version I hadn't tested yet is the linux-derived one:

struct __xchg_dummy { unsigned long a[100]; };
#define __xg(x) ((struct __xchg_dummy *)(x))
#define LOCK_PREFIX " lock "
static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
				      unsigned long newv)
{
	unsigned long prev;
		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
				     : "=a"(prev)
				     : "q"(newv), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
}
extern __inline__ long
ilockcmpexch (volatile long *t, long v, long c)
{
  return __cmpxchg (t, c, v);
}

  This actually produces the same assembly as my version:

L14:
	movl	__ZN13pthread_mutex7mutexesE, %eax	 # mutexes.head, D.2029
	movl	%eax, 36(%ebx)	 # D.2029, <variable>.next
/APP
 # 75 "mxfull.cpp" 1
	 lock cmpxchgl %ebx,__ZN13pthread_mutex7mutexesE	 # this,
 # 0 "" 2
/NO_APP
	cmpl	%eax, 36(%ebx)	 # prev, <variable>.next
	jne	L14	 #,


but it's a horrible bit of code.  Declaring the memory location as input only,
then clobbering all of memory and potentially confusing the optimisers with
type aliasing casts?  It makes me very uneasy.

    cheers,
      DaveK



--------------030706030600060909090007
Content-Type: text/plain;
 name="mxfull.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mxfull.cpp"
Content-length: 3503


// g++ -c mxfull.cpp -o mxfull.o --save-temps -O2 -fverbose-asm

typedef long LONG;
typedef void *HANDLE;
typedef void *PVOID;
typedef char *LPCSTR;

typedef class pthread_mutex *pthread_mutex_t;
typedef class pthread_mutexattr *pthread_mutexattr_t;
typedef class pthread *pthread_t;

struct SECURITY_ATTRIBUTES;
typedef struct SECURITY_ATTRIBUTES *LPSECURITY_ATTRIBUTES;
extern struct SECURITY_ATTRIBUTES sec_none_nih;

HANDLE __attribute__((__stdcall__)) CreateSemaphoreA(LPSECURITY_ATTRIBUTES,LONG,LONG,LPCSTR);

class verifyable_object
{
public:
  long magic;

  verifyable_object (long);
  virtual ~verifyable_object ();
};

#if 0
// My version
 extern __inline__ long
 ilockcmpexch (volatile long *t, long v, long c)
 {
  register long __res __asm ("%eax") = c;
   __asm__ __volatile__ ("\n\
	lock cmpxchgl %2,%1\n\
	": "+a" (__res), "=m" (*t) : "q" (v), "m" (*t) : "memory", "cc");
   return __res;
 }
#elif 0
// Original version
 extern __inline__ long
 ilockcmpexch (volatile long *t, long v, long c)
 {
  register int __res;
   __asm__ __volatile__ ("\n\
	lock cmpxchgl %3,(%1)\n\
	": "=a" (__res), "=q" (t) : "1" (t), "q" (v), "0" (c): "cc");
   return __res;
 }
#elif 0
// GlibC/uClibC version
extern __inline__ long
ilockcmpexch (volatile long *t, long v, long c)
{
  return ({
		__typeof (*t) ret;
		__asm __volatile ("lock cmpxchgl %2, %1"
			: "=a" (ret), "=m" (*t)
			: "r" (v), "m" (*t), "0" (c));
		ret;
	});
}
#elif 01
// Linux-2.6.8-1 version
struct __xchg_dummy { unsigned long a[100]; };
#define __xg(x) ((struct __xchg_dummy *)(x))
#define LOCK_PREFIX " lock "
static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
				      unsigned long newv)
{
	unsigned long prev;
		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
				     : "=a"(prev)
				     : "q"(newv), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
}
extern __inline__ long
ilockcmpexch (volatile long *t, long v, long c)
{
  return __cmpxchg (t, c, v);
}
#endif

class pthread_mutexattr: public verifyable_object
{
public:
  int pshared;
  int mutextype;
  pthread_mutexattr ();
  ~pthread_mutexattr ();
};

template <class list_node> inline void
List_insert (list_node *&head, list_node *node)
{
  if (!node)
    return;
  do
    node->next = head;
  while ((PVOID)ilockcmpexch((LONG volatile *)(&head),(LONG)(node),(LONG)(node->next)) != node->next);
}

template <class list_node> class List
{
 public:
  List() : head(__null)
  {
  }

  ~List()
  {
  }

  void insert (list_node *node)
  {
    List_insert (head, node);
  }

  list_node *head;

};

class pthread_mutex: public verifyable_object
{
public:

  unsigned long lock_counter;
  HANDLE win32_obj_id;
  unsigned int recursion_counter;
  LONG condwaits;
  pthread_t owner;



  int type;
  int pshared;


  pthread_mutex (pthread_mutexattr * = __null);
  ~pthread_mutex ();

  class pthread_mutex * next;

private:
  static List<pthread_mutex> mutexes;
};

List<pthread_mutex> pthread_mutex::mutexes;

pthread_mutex::pthread_mutex (pthread_mutexattr *attr) :
  verifyable_object (0xdf0df045 +1),
  lock_counter (0),
  win32_obj_id (__null), recursion_counter (0),
  condwaits (0), owner (__null),



  type (1),
  pshared (0)
{
  win32_obj_id = ::CreateSemaphoreA (&sec_none_nih, 0, 2147483647L, __null);
  if (!win32_obj_id)
    {
      magic = 0;
      return;
    }

  if (attr)
    {
      if (attr->pshared == 1)
 {

   magic = 0;
   return;
 }

      type = attr->mutextype;
    }

  mutexes.insert (this);
}


--------------030706030600060909090007--
