import unittest
import os
import testLib

class addTest(testLib.RestTestCase):


	def testAddBadUsername(self):

		longname = ""
		for i in range(0,30):
			longname = longname + "aaaaaa"
		
		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : '', 'password' : 'pw'})
		self.assertResponse(request,errCode = -3, count = None)

		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : longname, 'password' : 'pw'})
		self.assertResponse(request,errCode = -3, count = None)

	
	def testAddBadPassword(self):

		longname = ""
		for i in range(0,30):
			longname = longname + "aaaaaa"

		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'test', 'password' : ''})
		self.assertResponse(request,errCode = -4, count = None)

		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'test', 'password' : longname})
		self.assertResponse(request,errCode = -4, count = None)		

	def testAddTwice(self):
		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'carebear', 'password' : 'pw'})
		request2 = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'carebear', 'password' : 'pw'})
		self.assertResponse(request2,errCode = -2, count = None)
	
	def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
		expected = { 'errCode' : errCode }
		if count is not None:
			expected['count'] = count
		self.assertDictEqual(expected,respData)

class loginTest(testLib.RestTestCase):

	def testLoginWorks(self):
		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'alan', 'password' : 'pw'})
		request2 = self.makeRequest("/users/login", method = "POST", data = { 'user' : 'alan', 'password' : 'pw'})
		self.assertResponse(request2,errCode = 1, count = 2)

	def testCountWorks(self):
		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'netsky', 'password' : 'pw'})
		request2 = self.makeRequest("/users/login", method = "POST", data = { 'user' : 'netsky', 'password' : 'pw'})
		request3 = self.makeRequest("/users/login", method = "POST", data = { 'user' : 'netsky', 'password' : 'pw'})
		request4 = self.makeRequest("/users/login", method = "POST", data = { 'user' : 'netsky', 'password' : 'pw'})
		self.assertResponse(request4,errCode = 1, count = 4)

	def testLoginFails(self):
		request = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'rooney', 'password' : 'pw'})
		self.assertResponse(request,errCode = 1, count = 1)
		request2 = self.makeRequest("/users/login", method = "POST", data = { 'user' : 'rooney', 'password' : 'wrongpw'})
		self.assertResponse(request2, errCode = -1, count = None)

	def assertResponse(self,respData,count = 1, errCode = testLib.RestTestCase.SUCCESS):
		expected = { 'errCode' : errCode }
		if count is not None:
			expected['count'] = count
		self.assertDictEqual(expected,respData)

