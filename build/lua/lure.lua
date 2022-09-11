local _hx_hidden = {__id__=true, hx__closures=true, super=true, prototype=true, __fields__=true, __ifields__=true, __class__=true, __properties__=true, __fields__=true, __name__=true}

_hx_array_mt = {
    __newindex = function(t,k,v)
        local len = t.length
        t.length =  k >= len and (k + 1) or len
        rawset(t,k,v)
    end
}

function _hx_is_array(o)
    return type(o) == "table"
        and o.__enum__ == nil
        and getmetatable(o) == _hx_array_mt
end



function _hx_tab_array(tab, length)
    tab.length = length
    return setmetatable(tab, _hx_array_mt)
end



function _hx_print_class(obj, depth)
    local first = true
    local result = ''
    for k,v in pairs(obj) do
        if _hx_hidden[k] == nil then
            if first then
                first = false
            else
                result = result .. ', '
            end
            if _hx_hidden[k] == nil then
                result = result .. k .. ':' .. _hx_tostring(v, depth+1)
            end
        end
    end
    return '{ ' .. result .. ' }'
end

function _hx_print_enum(o, depth)
    if o.length == 2 then
        return o[0]
    else
        local str = o[0] .. "("
        for i = 2, (o.length-1) do
            if i ~= 2 then
                str = str .. "," .. _hx_tostring(o[i], depth+1)
            else
                str = str .. _hx_tostring(o[i], depth+1)
            end
        end
        return str .. ")"
    end
end

function _hx_tostring(obj, depth)
    if depth == nil then
        depth = 0
    elseif depth > 5 then
        return "<...>"
    end

    local tstr = _G.type(obj)
    if tstr == "string" then return obj
    elseif tstr == "nil" then return "null"
    elseif tstr == "number" then
        if obj == _G.math.POSITIVE_INFINITY then return "Infinity"
        elseif obj == _G.math.NEGATIVE_INFINITY then return "-Infinity"
        elseif obj == 0 then return "0"
        elseif obj ~= obj then return "NaN"
        else return _G.tostring(obj)
        end
    elseif tstr == "boolean" then return _G.tostring(obj)
    elseif tstr == "userdata" then
        local mt = _G.getmetatable(obj)
        if mt ~= nil and mt.__tostring ~= nil then
            return _G.tostring(obj)
        else
            return "<userdata>"
        end
    elseif tstr == "function" then return "<function>"
    elseif tstr == "thread" then return "<thread>"
    elseif tstr == "table" then
        if obj.__enum__ ~= nil then
            return _hx_print_enum(obj, depth)
        elseif obj.toString ~= nil and not _hx_is_array(obj) then return obj:toString()
        elseif _hx_is_array(obj) then
            if obj.length > 5 then
                return "[...]"
            else
                local str = ""
                for i=0, (obj.length-1) do
                    if i == 0 then
                        str = str .. _hx_tostring(obj[i], depth+1)
                    else
                        str = str .. "," .. _hx_tostring(obj[i], depth+1)
                    end
                end
                return "[" .. str .. "]"
            end
        elseif obj.__class__ ~= nil then
            return _hx_print_class(obj, depth)
        else
            local buffer = {}
            local ref = obj
            if obj.__fields__ ~= nil then
                ref = obj.__fields__
            end
            for k,v in pairs(ref) do
                if _hx_hidden[k] == nil then
                    _G.table.insert(buffer, _hx_tostring(k, depth+1) .. ' : ' .. _hx_tostring(obj[k], depth+1))
                end
            end

            return "{ " .. table.concat(buffer, ", ") .. " }"
        end
    else
        _G.error("Unknown Lua type", 0)
        return ""
    end
end

function _hx_error(obj)
    if obj.value then
        _G.print("runtime error:\n " .. _hx_tostring(obj.value));
    else
        _G.print("runtime error:\n " .. tostring(obj));
    end

    if _G.debug and _G.debug.traceback then
        _G.print(debug.traceback());
    end
end


local function _hx_obj_newindex(t,k,v)
    t.__fields__[k] = true
    rawset(t,k,v)
end

local _hx_obj_mt = {__newindex=_hx_obj_newindex, __tostring=_hx_tostring}

local function _hx_a(...)
  local __fields__ = {};
  local ret = {__fields__ = __fields__};
  local max = select('#',...);
  local tab = {...};
  local cur = 1;
  while cur < max do
    local v = tab[cur];
    __fields__[v] = true;
    ret[v] = tab[cur+1];
    cur = cur + 2
  end
  return setmetatable(ret, _hx_obj_mt)
end

local function _hx_e()
  return setmetatable({__fields__ = {}}, _hx_obj_mt)
end

local function _hx_o(obj)
  return setmetatable(obj, _hx_obj_mt)
end

local function _hx_new(prototype)
  return setmetatable({__fields__ = {}}, {__newindex=_hx_obj_newindex, __index=prototype, __tostring=_hx_tostring})
end

function _hx_field_arr(obj)
    res = {}
    idx = 0
    if obj.__fields__ ~= nil then
        obj = obj.__fields__
    end
    for k,v in pairs(obj) do
        if _hx_hidden[k] == nil then
            res[idx] = k
            idx = idx + 1
        end
    end
    return _hx_tab_array(res, idx)
end

local _hxClasses = {}
local Int = _hx_e();
local Dynamic = _hx_e();
local Float = _hx_e();
local Bool = _hx_e();
local Class = _hx_e();
local Enum = _hx_e();

local _hx_exports = _hx_exports or {}
local Array = _hx_e()
local Attr = _hx_e()
___DOMTokenList_DOMTokenList_Impl_ = _hx_e()
local EventTarget = _hx_e()
local Node = _hx_e()
local Document = _hx_e()
__lua_lib_luautf8_Utf8 = _G.require("lua-utf8")
local Element = _hx_e()
local Exceptions = _hx_e()
local HTMLDocument = _hx_e()
local HTMLLexer = _hx_e()
local HTMLParser = _hx_e()
local HTMLToken = _hx_e()
local HTMLTokenType = _hx_e()
local Math = _hx_e()
___NamedNodeMap_NamedNodeMap_Impl_ = _hx_e()
___NodeList_NodeList_Impl_ = _hx_e()
local String = _hx_e()
local Std = _hx_e()
__haxe_IMap = _hx_e()
__haxe_Exception = _hx_e()
__haxe_NativeStackTrace = _hx_e()
__haxe_ValueException = _hx_e()
__haxe_ds_List = _hx_e()
__haxe_ds_ObjectMap = _hx_e()
__haxe_ds_StringMap = _hx_e()
__haxe_exceptions_PosException = _hx_e()
__haxe_exceptions_NotImplementedException = _hx_e()
__haxe_io_Bytes = _hx_e()
__haxe_io_Input = _hx_e()
__haxe_io_BytesInput = _hx_e()
__haxe_io_Encoding = _hx_e()
__haxe_io_Eof = _hx_e()
__haxe_io_Error = _hx_e()
__haxe_io_StringInput = _hx_e()
__haxe_iterators_ArrayIterator = _hx_e()
__haxe_iterators_ArrayKeyValueIterator = _hx_e()
__lua_Boot = _hx_e()
__lua_UserData = _hx_e()
__lua_Thread = _hx_e()

local _hx_bind, _hx_bit, _hx_staticToInstance, _hx_funcToField, _hx_maxn, _hx_print, _hx_apply_self, _hx_box_mr, _hx_bit_clamp, _hx_table, _hx_bit_raw
local _hx_pcall_default = {};
local _hx_pcall_break = {};

Array.new = function()
  local self = _hx_new(Array.prototype)
  Array.super(self)
  return self
end
Array.super = function(self)
  _hx_tab_array(self, 0);
end
Array.__name__ = true
Array.prototype = _hx_e();
Array.prototype.concat = function(self,a)
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  local _g2 = self;
  while (_g1 < _g2.length) do
    local i = _g2[_g1];
    _g1 = _g1 + 1;
    _g:push(i);
  end;
  local ret = _g;
  local _g = 0;
  while (_g < a.length) do
    local i = a[_g];
    _g = _g + 1;
    ret:push(i);
  end;
  do return ret end
end
Array.prototype.join = function(self,sep)
  local tbl = ({});
  local _g_current = 0;
  local _g_array = self;
  while (_g_current < _g_array.length) do
    _g_current = _g_current + 1;
    local i = _g_array[_g_current - 1];
    _G.table.insert(tbl, Std.string(i));
  end;
  do return _G.table.concat(tbl, sep) end
end
Array.prototype.pop = function(self)
  if (self.length == 0) then
    do return nil end;
  end;
  local ret = self[self.length - 1];
  self[self.length - 1] = nil;
  self.length = self.length - 1;
  do return ret end
end
Array.prototype.push = function(self,x)
  self[self.length] = x;
  do return self.length end
end
Array.prototype.reverse = function(self)
  local tmp;
  local i = 0;
  while (i < Std.int(self.length / 2)) do
    tmp = self[i];
    self[i] = self[(self.length - i) - 1];
    self[(self.length - i) - 1] = tmp;
    i = i + 1;
  end;
end
Array.prototype.shift = function(self)
  if (self.length == 0) then
    do return nil end;
  end;
  local ret = self[0];
  if (self.length == 1) then
    self[0] = nil;
  else
    if (self.length > 1) then
      self[0] = self[1];
      _G.table.remove(self, 1);
    end;
  end;
  local tmp = self;
  tmp.length = tmp.length - 1;
  do return ret end
end
Array.prototype.slice = function(self,pos,_end)
  if ((_end == nil) or (_end > self.length)) then
    _end = self.length;
  else
    if (_end < 0) then
      _end = _G.math.fmod((self.length - (_G.math.fmod(-_end, self.length))), self.length);
    end;
  end;
  if (pos < 0) then
    pos = _G.math.fmod((self.length - (_G.math.fmod(-pos, self.length))), self.length);
  end;
  if ((pos > _end) or (pos > self.length)) then
    do return _hx_tab_array({}, 0) end;
  end;
  local ret = _hx_tab_array({}, 0);
  local _g = pos;
  local _g1 = _end;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    ret:push(self[i]);
  end;
  do return ret end
end
Array.prototype.sort = function(self,f)
  local i = 0;
  local l = self.length;
  while (i < l) do
    local swap = false;
    local j = 0;
    local max = (l - i) - 1;
    while (j < max) do
      if (f(self[j], self[j + 1]) > 0) then
        local tmp = self[j + 1];
        self[j + 1] = self[j];
        self[j] = tmp;
        swap = true;
      end;
      j = j + 1;
    end;
    if (not swap) then
      break;
    end;
    i = i + 1;
  end;
end
Array.prototype.splice = function(self,pos,len)
  if ((len < 0) or (pos > self.length)) then
    do return _hx_tab_array({}, 0) end;
  else
    if (pos < 0) then
      pos = self.length - (_G.math.fmod(-pos, self.length));
    end;
  end;
  len = Math.min(len, self.length - pos);
  local ret = _hx_tab_array({}, 0);
  local _g = pos;
  local _g1 = pos + len;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    ret:push(self[i]);
    self[i] = self[i + len];
  end;
  local _g = pos + len;
  local _g1 = self.length;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    self[i] = self[i + len];
  end;
  local tmp = self;
  tmp.length = tmp.length - len;
  do return ret end
end
Array.prototype.toString = function(self)
  local tbl = ({});
  _G.table.insert(tbl, "[");
  _G.table.insert(tbl, self:join(","));
  _G.table.insert(tbl, "]");
  do return _G.table.concat(tbl, "") end
end
Array.prototype.unshift = function(self,x)
  local len = self.length;
  local _g = 0;
  local _g1 = len;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    self[len - i] = self[(len - i) - 1];
  end;
  self[0] = x;
end
Array.prototype.insert = function(self,pos,x)
  if (pos > self.length) then
    pos = self.length;
  end;
  if (pos < 0) then
    pos = self.length + pos;
    if (pos < 0) then
      pos = 0;
    end;
  end;
  local cur_len = self.length;
  while (cur_len > pos) do
    self[cur_len] = self[cur_len - 1];
    cur_len = cur_len - 1;
  end;
  self[pos] = x;
end
Array.prototype.remove = function(self,x)
  local _g = 0;
  local _g1 = self.length;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    if (self[i] == x) then
      local _g = i;
      local _g1 = self.length - 1;
      while (_g < _g1) do
        _g = _g + 1;
        local j = _g - 1;
        self[j] = self[j + 1];
      end;
      self[self.length - 1] = nil;
      self.length = self.length - 1;
      do return true end;
    end;
  end;
  do return false end
end
Array.prototype.contains = function(self,x)
  local _g = 0;
  local _g1 = self.length;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    if (self[i] == x) then
      do return true end;
    end;
  end;
  do return false end
end
Array.prototype.indexOf = function(self,x,fromIndex)
  local _end = self.length;
  if (fromIndex == nil) then
    fromIndex = 0;
  else
    if (fromIndex < 0) then
      fromIndex = self.length + fromIndex;
      if (fromIndex < 0) then
        fromIndex = 0;
      end;
    end;
  end;
  local _g = fromIndex;
  local _g1 = _end;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    if (x == self[i]) then
      do return i end;
    end;
  end;
  do return -1 end
end
Array.prototype.lastIndexOf = function(self,x,fromIndex)
  if ((fromIndex == nil) or (fromIndex >= self.length)) then
    fromIndex = self.length - 1;
  else
    if (fromIndex < 0) then
      fromIndex = self.length + fromIndex;
      if (fromIndex < 0) then
        do return -1 end;
      end;
    end;
  end;
  local i = fromIndex;
  while (i >= 0) do
    if (self[i] == x) then
      do return i end;
    else
      i = i - 1;
    end;
  end;
  do return -1 end
end
Array.prototype.copy = function(self)
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  local _g2 = self;
  while (_g1 < _g2.length) do
    local i = _g2[_g1];
    _g1 = _g1 + 1;
    _g:push(i);
  end;
  do return _g end
end
Array.prototype.map = function(self,f)
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  local _g2 = self;
  while (_g1 < _g2.length) do
    local i = _g2[_g1];
    _g1 = _g1 + 1;
    _g:push(f(i));
  end;
  do return _g end
end
Array.prototype.filter = function(self,f)
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  local _g2 = self;
  while (_g1 < _g2.length) do
    local i = _g2[_g1];
    _g1 = _g1 + 1;
    if (f(i)) then
      _g:push(i);
    end;
  end;
  do return _g end
end
Array.prototype.iterator = function(self)
  do return __haxe_iterators_ArrayIterator.new(self) end
end
Array.prototype.keyValueIterator = function(self)
  do return __haxe_iterators_ArrayKeyValueIterator.new(self) end
end
Array.prototype.resize = function(self,len)
  if (self.length < len) then
    self.length = len;
  else
    if (self.length > len) then
      local _g = len;
      local _g1 = self.length;
      while (_g < _g1) do
        _g = _g + 1;
        local i = _g - 1;
        self[i] = nil;
      end;
      self.length = len;
    end;
  end;
end

Array.prototype.__class__ =  Array

Attr.new = {}
Attr.__name__ = true

___DOMTokenList_DOMTokenList_Impl_.new = {}
___DOMTokenList_DOMTokenList_Impl_.__name__ = true
___DOMTokenList_DOMTokenList_Impl_._new = function()
  local this1 = Array.new();
  do return this1 end;
end

EventTarget.new = function()
  local self = _hx_new(EventTarget.prototype)
  EventTarget.super(self)
  return self
end
EventTarget.super = function(self)
end
_hx_exports["EventTarget"] = EventTarget
EventTarget.__name__ = true
EventTarget.prototype = _hx_e();
EventTarget.prototype.addEventListener = function(self,type,listener)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
EventTarget.prototype.dispatchEvent = function(self)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
EventTarget.prototype.removeEventListener = function(self)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end

EventTarget.prototype.__class__ =  EventTarget

Node.new = function()
  local self = _hx_new(Node.prototype)
  Node.super(self)
  return self
end
Node.super = function(self)
  self.childNodes = ___NodeList_NodeList_Impl_._new();
  EventTarget.super(self);
end
_hx_exports["Node"] = Node
Node.__name__ = true
Node.prototype = _hx_e();
Node.prototype.appendChild = function(self,child)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.cloneNode = function(self,deep)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.compareDocumentPosition = function(self,node)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.contains = function(self,node)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.hasChildNodes = function(self)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.insertBefore = function(self,newNode,referenceNode)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.isDefaultNamespace = function(self,namespaceURI)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.isEqualNode = function(self,otherNode)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.isSameNode = function(self,other)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.lookupNamespaceURI = function(self,prefix)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.lookupPrefix = function(self)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.normalize = function(self)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.removeChild = function(self,child)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Node.prototype.replaceChild = function(self,newChild,oldChild)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end

Node.prototype.__class__ =  Node
Node.__super__ = EventTarget
setmetatable(Node.prototype,{__index=EventTarget.prototype})

Document.new = function()
  local self = _hx_new(Document.prototype)
  Document.super(self)
  return self
end
Document.super = function(self)
  Node.super(self);
end
_hx_exports["Document"] = Document
Document.__name__ = true
Document.prototype = _hx_e();

Document.prototype.__class__ =  Document
Document.__super__ = Node
setmetatable(Document.prototype,{__index=Node.prototype})

Element.new = function()
  local self = _hx_new(Element.prototype)
  Element.super(self)
  return self
end
Element.super = function(self)
  self.tagName = "";
  self.namespaceURI = nil;
  self.localName = "";
  self.innerHTML = "";
  self.id = "";
  self.computedRole = "";
  self.computedName = "";
  self.className = "";
  self.classList = ___DOMTokenList_DOMTokenList_Impl_._new();
  self.attributes = ___NamedNodeMap_NamedNodeMap_Impl_._new();
  Node.super(self);
end
_hx_exports["Element"] = Element
Element.__name__ = true
Element.prototype = _hx_e();
Element.prototype.getAttribute = function(self,name)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Element.prototype.getAttributeNames = function(self)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Element.prototype.getAttributeNS = function(self,namespace,name)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end
Element.prototype.set_innerHTML = function(self,html)
  _G.error(__haxe_Exception.thrown(Exceptions.NotImplemented),0);
end

Element.prototype.__class__ =  Element
Element.__super__ = Node
setmetatable(Element.prototype,{__index=Node.prototype})

Exceptions.new = {}
_hx_exports["Exceptions"] = Exceptions
Exceptions.__name__ = true

HTMLDocument.new = function()
  local self = _hx_new(HTMLDocument.prototype)
  HTMLDocument.super(self)
  return self
end
HTMLDocument.super = function(self)
  Document.super(self);
end
_hx_exports["HTMLDocument"] = HTMLDocument
HTMLDocument.__name__ = true
HTMLDocument.prototype = _hx_e();

HTMLDocument.prototype.__class__ =  HTMLDocument
HTMLDocument.__super__ = Document
setmetatable(HTMLDocument.prototype,{__index=Document.prototype})

HTMLLexer.new = function(input)
  local self = _hx_new(HTMLLexer.prototype)
  HTMLLexer.super(self,input)
  return self
end
HTMLLexer.super = function(self,input)
  self.emitted = __haxe_ds_ObjectMap.new();
  self.input = input;
end
HTMLLexer.__name__ = true
HTMLLexer.prototype = _hx_e();
HTMLLexer.prototype.next = function(self)
  local token = self:getToken();
  while (true) do
    local char = self.input:read(1):toString();
    if (char == "<") then
      token.type = HTMLTokenType.TagOpen;
      self:openNode(token);
      break;
    end;
  end;
  do return token end
end
HTMLLexer.prototype.getToken = function(self)
  local emittedIter = self.emitted:keys();
  while (emittedIter:hasNext()) do
    local token = emittedIter:next();
    if (self.emitted.h[token] == true) then
      local _this = self.emitted;
      _this.h[token] = false;
      _this.k[token] = true;
      do return token end;
    end;
  end;
  local token = HTMLToken.new();
  local _this = self.emitted;
  _this.h[token] = false;
  _this.k[token] = true;
  do return token end
end
HTMLLexer.prototype.openNode = function(self,token)
  local fulltag = "";
  local tagbuffer = "";
  local _hx_continue_1 = false;
  while (true) do repeat
    local char = self.input:read(1):toString();
    if (char == " ") then
      _hx_continue_1 = true;break;
    else
      break;
    end;until true
    if _hx_continue_1 then
    _hx_continue_1 = false;
    break;
    end;

  end;
end

HTMLLexer.prototype.__class__ =  HTMLLexer

HTMLParser.new = function()
  local self = _hx_new(HTMLParser.prototype)
  HTMLParser.super(self)
  return self
end
HTMLParser.super = function(self)
  self.stack = __haxe_ds_List.new();
end
_hx_exports["HTMLParser"] = HTMLParser
HTMLParser.__name__ = true
HTMLParser.prototype = _hx_e();
HTMLParser.prototype.parseFromString = function(self,str)
  local doc = HTMLDocument.new();
  local lex = HTMLLexer.new(__haxe_io_StringInput.new(str));
  local eof = false;
  while (not eof) do
    local token = lex:next();
    local tmp = token.type[1];
    if (tmp) == 1 then
      self:openTag(token);
    elseif (tmp) == 2 then
      self:closeTag(token);
    elseif (tmp) == 4 then
      self:handleComment(token);
    elseif (tmp) == 5 then
      self:handleCdata(token);
    elseif (tmp) == 6 then
      eof = true;else
    _G.error(__haxe_Exception.thrown("unknown token"),0); end;
  end;
  do return doc end
end
HTMLParser.prototype.openTag = function(self,token)
  local isUnknownElement = HTMLParser.elements:indexOf(__lua_lib_luautf8_Utf8.lower(token.tagOpenData.name)) > -1;
end
HTMLParser.prototype.closeTag = function(self,token)
end
HTMLParser.prototype.handleCdata = function(self,token)
end
HTMLParser.prototype.handleComment = function(self,token)
end

HTMLParser.prototype.__class__ =  HTMLParser

HTMLToken.new = function()
  local self = _hx_new(HTMLToken.prototype)
  HTMLToken.super(self)
  return self
end
HTMLToken.super = function(self)
  self.commentData = _hx_o({__fields__={text=true},text=""});
  self.cdataSectionData = _hx_o({__fields__={text=true},text=""});
  self.tagCloseData = _hx_o({__fields__={ns=true,name=true},ns="",name=""});
  self.tagOpenData = _hx_o({__fields__={ns=true,name=true,attr=true},ns="",name="",attr=__haxe_ds_StringMap.new()});
end
_hx_exports["HTMLToken"] = HTMLToken
HTMLToken.__name__ = true
HTMLToken.prototype = _hx_e();
HTMLToken.prototype.clear = function(self)
  self.type = HTMLTokenType.Unknown;
  self.cdataSectionData.text = "";
  self.commentData.text = "";
  self.tagCloseData.name = "";
  self.tagCloseData.ns = "";
  self.tagOpenData.name = "";
  self.tagOpenData.ns = "";
  local todi = self.tagOpenData.attr:keys();
  while (todi:hasNext()) do
    self.tagOpenData.attr:remove(todi:next());
  end;
end

HTMLToken.prototype.__class__ =  HTMLToken
_hxClasses["HTMLTokenType"] = { __ename__ = true, __constructs__ = _hx_tab_array({[0]="Unknown","TagOpen","TagClose","Text","Comment","CdataSection","EOF"},7)}
HTMLTokenType = _hxClasses["HTMLTokenType"];
HTMLTokenType.Unknown = _hx_tab_array({[0]="Unknown",0,__enum__ = HTMLTokenType},2)

HTMLTokenType.TagOpen = _hx_tab_array({[0]="TagOpen",1,__enum__ = HTMLTokenType},2)

HTMLTokenType.TagClose = _hx_tab_array({[0]="TagClose",2,__enum__ = HTMLTokenType},2)

HTMLTokenType.Text = _hx_tab_array({[0]="Text",3,__enum__ = HTMLTokenType},2)

HTMLTokenType.Comment = _hx_tab_array({[0]="Comment",4,__enum__ = HTMLTokenType},2)

HTMLTokenType.CdataSection = _hx_tab_array({[0]="CdataSection",5,__enum__ = HTMLTokenType},2)

HTMLTokenType.EOF = _hx_tab_array({[0]="EOF",6,__enum__ = HTMLTokenType},2)


Math.new = {}
Math.__name__ = true
Math.isNaN = function(f)
  do return f ~= f end;
end
Math.isFinite = function(f)
  if (f > -_G.math.huge) then
    do return f < _G.math.huge end;
  else
    do return false end;
  end;
end
Math.min = function(a,b)
  if (Math.isNaN(a) or Math.isNaN(b)) then
    do return (0/0) end;
  else
    do return _G.math.min(a, b) end;
  end;
end

___NamedNodeMap_NamedNodeMap_Impl_.new = {}
___NamedNodeMap_NamedNodeMap_Impl_.__name__ = true
___NamedNodeMap_NamedNodeMap_Impl_._new = function()
  local this1 = __haxe_ds_StringMap.new();
  do return this1 end;
end

___NodeList_NodeList_Impl_.new = {}
___NodeList_NodeList_Impl_.__name__ = true
___NodeList_NodeList_Impl_._new = function()
  local this1 = Array.new();
  do return this1 end;
end

String.new = function(string)
  local self = _hx_new(String.prototype)
  String.super(self,string)
  self = string
  return self
end
String.super = function(self,string)
end
String.__name__ = true
String.__index = function(s,k)
  if (k == "length") then
    do return __lua_lib_luautf8_Utf8.len(s) end;
  else
    local o = String.prototype;
    local field = k;
    if ((function()
      local _hx_1
      if ((_G.type(o) == "string") and ((String.prototype[field] ~= nil) or (field == "length"))) then
      _hx_1 = true; elseif (o.__fields__ ~= nil) then
      _hx_1 = o.__fields__[field] ~= nil; else
      _hx_1 = o[field] ~= nil; end
      return _hx_1
    end )()) then
      do return String.prototype[k] end;
    else
      if (String.__oldindex ~= nil) then
        if (_G.type(String.__oldindex) == "function") then
          do return String.__oldindex(s, k) end;
        else
          if (_G.type(String.__oldindex) == "table") then
            do return String.__oldindex[k] end;
          end;
        end;
        do return nil end;
      else
        do return nil end;
      end;
    end;
  end;
end
String.indexOfEmpty = function(s,startIndex)
  local length = __lua_lib_luautf8_Utf8.len(s);
  if (startIndex < 0) then
    startIndex = length + startIndex;
    if (startIndex < 0) then
      startIndex = 0;
    end;
  end;
  if (startIndex > length) then
    do return length end;
  else
    do return startIndex end;
  end;
end
String.fromCharCode = function(code)
  do return __lua_lib_luautf8_Utf8.char(code) end;
end
String.prototype = _hx_e();
String.prototype.toUpperCase = function(self)
  do return __lua_lib_luautf8_Utf8.upper(self) end
end
String.prototype.toLowerCase = function(self)
  do return __lua_lib_luautf8_Utf8.lower(self) end
end
String.prototype.indexOf = function(self,str,startIndex)
  if (startIndex == nil) then
    startIndex = 1;
  else
    startIndex = startIndex + 1;
  end;
  if (str == "") then
    do return String.indexOfEmpty(self, startIndex - 1) end;
  end;
  local r = __lua_lib_luautf8_Utf8.find(self, str, startIndex, true);
  if ((r ~= nil) and (r > 0)) then
    do return r - 1 end;
  else
    do return -1 end;
  end;
end
String.prototype.lastIndexOf = function(self,str,startIndex)
  local ret = -1;
  if (startIndex == nil) then
    startIndex = __lua_lib_luautf8_Utf8.len(self);
  end;
  while (true) do
    local startIndex1 = ret + 1;
    if (startIndex1 == nil) then
      startIndex1 = 1;
    else
      startIndex1 = startIndex1 + 1;
    end;
    local p;
    if (str == "") then
      p = String.indexOfEmpty(self, startIndex1 - 1);
    else
      local r = __lua_lib_luautf8_Utf8.find(self, str, startIndex1, true);
      p = (function()
        local _hx_1
        if ((r ~= nil) and (r > 0)) then
        _hx_1 = r - 1; else
        _hx_1 = -1; end
        return _hx_1
      end )();
    end;
    if (((p == -1) or (p > startIndex)) or (p == ret)) then
      break;
    end;
    ret = p;
  end;
  do return ret end
end
String.prototype.split = function(self,delimiter)
  local idx = 1;
  local ret = _hx_tab_array({}, 0);
  while (idx ~= nil) do
    local newidx = 0;
    if (__lua_lib_luautf8_Utf8.len(delimiter) > 0) then
      newidx = __lua_lib_luautf8_Utf8.find(self, delimiter, idx, true);
    else
      if (idx >= __lua_lib_luautf8_Utf8.len(self)) then
        newidx = nil;
      else
        newidx = idx + 1;
      end;
    end;
    if (newidx ~= nil) then
      local match = __lua_lib_luautf8_Utf8.sub(self, idx, newidx - 1);
      ret:push(match);
      idx = newidx + __lua_lib_luautf8_Utf8.len(delimiter);
    else
      ret:push(__lua_lib_luautf8_Utf8.sub(self, idx, __lua_lib_luautf8_Utf8.len(self)));
      idx = nil;
    end;
  end;
  do return ret end
end
String.prototype.toString = function(self)
  do return self end
end
String.prototype.substring = function(self,startIndex,endIndex)
  if (endIndex == nil) then
    endIndex = __lua_lib_luautf8_Utf8.len(self);
  end;
  if (endIndex < 0) then
    endIndex = 0;
  end;
  if (startIndex < 0) then
    startIndex = 0;
  end;
  if (endIndex < startIndex) then
    do return __lua_lib_luautf8_Utf8.sub(self, endIndex + 1, startIndex) end;
  else
    do return __lua_lib_luautf8_Utf8.sub(self, startIndex + 1, endIndex) end;
  end;
end
String.prototype.charAt = function(self,index)
  do return __lua_lib_luautf8_Utf8.sub(self, index + 1, index + 1) end
end
String.prototype.charCodeAt = function(self,index)
  do return __lua_lib_luautf8_Utf8.byte(self, index + 1) end
end
String.prototype.substr = function(self,pos,len)
  if ((len == nil) or (len > (pos + __lua_lib_luautf8_Utf8.len(self)))) then
    len = __lua_lib_luautf8_Utf8.len(self);
  else
    if (len < 0) then
      len = __lua_lib_luautf8_Utf8.len(self) + len;
    end;
  end;
  if (pos < 0) then
    pos = __lua_lib_luautf8_Utf8.len(self) + pos;
  end;
  if (pos < 0) then
    pos = 0;
  end;
  do return __lua_lib_luautf8_Utf8.sub(self, pos + 1, pos + len) end
end

String.prototype.__class__ =  String

Std.new = {}
Std.__name__ = true
Std.string = function(s)
  do return _hx_tostring(s, 0) end;
end
Std.int = function(x)
  if (not Math.isFinite(x) or Math.isNaN(x)) then
    do return 0 end;
  else
    do return _hx_bit_clamp(x) end;
  end;
end

__haxe_IMap.new = {}
__haxe_IMap.__name__ = true

__haxe_Exception.new = function(message,previous,native)
  local self = _hx_new(__haxe_Exception.prototype)
  __haxe_Exception.super(self,message,previous,native)
  return self
end
__haxe_Exception.super = function(self,message,previous,native)
  self.__skipStack = 0;
  self.__exceptionMessage = message;
  self.__previousException = previous;
  if (native ~= nil) then
    self.__nativeException = native;
    self.__nativeStack = __haxe_NativeStackTrace.exceptionStack();
  else
    self.__nativeException = self;
    self.__nativeStack = __haxe_NativeStackTrace.callStack();
    self.__skipStack = 1;
  end;
end
__haxe_Exception.__name__ = true
__haxe_Exception.caught = function(value)
  if (__lua_Boot.__instanceof(value, __haxe_Exception)) then
    do return value end;
  else
    do return __haxe_ValueException.new(value, nil, value) end;
  end;
end
__haxe_Exception.thrown = function(value)
  if (__lua_Boot.__instanceof(value, __haxe_Exception)) then
    do return value:get_native() end;
  else
    local e = __haxe_ValueException.new(value);
    e.__skipStack = e.__skipStack + 1;
    do return e end;
  end;
end
__haxe_Exception.prototype = _hx_e();
__haxe_Exception.prototype.unwrap = function(self)
  do return self.__nativeException end
end
__haxe_Exception.prototype.toString = function(self)
  do return self:get_message() end
end
__haxe_Exception.prototype.get_message = function(self)
  do return self.__exceptionMessage end
end
__haxe_Exception.prototype.get_native = function(self)
  do return self.__nativeException end
end

__haxe_Exception.prototype.__class__ =  __haxe_Exception

__haxe_NativeStackTrace.new = {}
__haxe_NativeStackTrace.__name__ = true
__haxe_NativeStackTrace.saveStack = function(exception)
end
__haxe_NativeStackTrace.callStack = function()
  local _g = debug.traceback();
  if (_g == nil) then
    do return _hx_tab_array({}, 0) end;
  else
    local s = _g;
    local idx = 1;
    local ret = _hx_tab_array({}, 0);
    while (idx ~= nil) do
      local newidx = 0;
      if (__lua_lib_luautf8_Utf8.len("\n") > 0) then
        newidx = __lua_lib_luautf8_Utf8.find(s, "\n", idx, true);
      else
        if (idx >= __lua_lib_luautf8_Utf8.len(s)) then
          newidx = nil;
        else
          newidx = idx + 1;
        end;
      end;
      if (newidx ~= nil) then
        local match = __lua_lib_luautf8_Utf8.sub(s, idx, newidx - 1);
        ret:push(match);
        idx = newidx + __lua_lib_luautf8_Utf8.len("\n");
      else
        ret:push(__lua_lib_luautf8_Utf8.sub(s, idx, __lua_lib_luautf8_Utf8.len(s)));
        idx = nil;
      end;
    end;
    do return ret:slice(3) end;
  end;
end
__haxe_NativeStackTrace.exceptionStack = function()
  do return _hx_tab_array({}, 0) end;
end

__haxe_ValueException.new = function(value,previous,native)
  local self = _hx_new(__haxe_ValueException.prototype)
  __haxe_ValueException.super(self,value,previous,native)
  return self
end
__haxe_ValueException.super = function(self,value,previous,native)
  __haxe_Exception.super(self,Std.string(value),previous,native);
  self.value = value;
end
__haxe_ValueException.__name__ = true
__haxe_ValueException.prototype = _hx_e();
__haxe_ValueException.prototype.unwrap = function(self)
  do return self.value end
end

__haxe_ValueException.prototype.__class__ =  __haxe_ValueException
__haxe_ValueException.__super__ = __haxe_Exception
setmetatable(__haxe_ValueException.prototype,{__index=__haxe_Exception.prototype})

__haxe_ds_List.new = function()
  local self = _hx_new(__haxe_ds_List.prototype)
  __haxe_ds_List.super(self)
  return self
end
__haxe_ds_List.super = function(self)
  self.length = 0;
end
__haxe_ds_List.__name__ = true
__haxe_ds_List.prototype = _hx_e();

__haxe_ds_List.prototype.__class__ =  __haxe_ds_List

__haxe_ds_ObjectMap.new = function()
  local self = _hx_new(__haxe_ds_ObjectMap.prototype)
  __haxe_ds_ObjectMap.super(self)
  return self
end
__haxe_ds_ObjectMap.super = function(self)
  self.h = ({});
  self.k = ({});
end
__haxe_ds_ObjectMap.__name__ = true
__haxe_ds_ObjectMap.__interfaces__ = {__haxe_IMap}
__haxe_ds_ObjectMap.prototype = _hx_e();
__haxe_ds_ObjectMap.prototype.keys = function(self)
  local _gthis = self;
  local cur = next(self.h, nil);
  do return _hx_o({__fields__={next=true,hasNext=true},next=function(self)
    local ret = cur;
    cur = next(_gthis.k, cur);
    do return ret end;
  end,hasNext=function(self)
    do return cur ~= nil end;
  end}) end
end

__haxe_ds_ObjectMap.prototype.__class__ =  __haxe_ds_ObjectMap

__haxe_ds_StringMap.new = function()
  local self = _hx_new(__haxe_ds_StringMap.prototype)
  __haxe_ds_StringMap.super(self)
  return self
end
__haxe_ds_StringMap.super = function(self)
  self.h = ({});
end
__haxe_ds_StringMap.__name__ = true
__haxe_ds_StringMap.__interfaces__ = {__haxe_IMap}
__haxe_ds_StringMap.prototype = _hx_e();
__haxe_ds_StringMap.prototype.remove = function(self,key)
  if (self.h[key] == nil) then
    do return false end;
  else
    self.h[key] = nil;
    do return true end;
  end;
end
__haxe_ds_StringMap.prototype.keys = function(self)
  local _gthis = self;
  local next = _G.next;
  local cur = next(self.h, nil);
  do return _hx_o({__fields__={next=true,hasNext=true},next=function(self)
    local ret = cur;
    cur = next(_gthis.h, cur);
    do return ret end;
  end,hasNext=function(self)
    do return cur ~= nil end;
  end}) end
end

__haxe_ds_StringMap.prototype.__class__ =  __haxe_ds_StringMap

__haxe_exceptions_PosException.new = function(message,previous,pos)
  local self = _hx_new(__haxe_exceptions_PosException.prototype)
  __haxe_exceptions_PosException.super(self,message,previous,pos)
  return self
end
__haxe_exceptions_PosException.super = function(self,message,previous,pos)
  __haxe_Exception.super(self,message,previous);
  if (pos == nil) then
    self.posInfos = _hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="(unknown)",lineNumber=0,className="(unknown)",methodName="(unknown)"});
  else
    self.posInfos = pos;
  end;
end
__haxe_exceptions_PosException.__name__ = true
__haxe_exceptions_PosException.prototype = _hx_e();
__haxe_exceptions_PosException.prototype.toString = function(self)
  do return Std.string(Std.string(Std.string(Std.string(Std.string(Std.string(Std.string(Std.string(Std.string("") .. Std.string(__haxe_Exception.prototype.toString(self))) .. Std.string(" in ")) .. Std.string(self.posInfos.className)) .. Std.string(".")) .. Std.string(self.posInfos.methodName)) .. Std.string(" at ")) .. Std.string(self.posInfos.fileName)) .. Std.string(":")) .. Std.string(self.posInfos.lineNumber) end
end

__haxe_exceptions_PosException.prototype.__class__ =  __haxe_exceptions_PosException
__haxe_exceptions_PosException.__super__ = __haxe_Exception
setmetatable(__haxe_exceptions_PosException.prototype,{__index=__haxe_Exception.prototype})

__haxe_exceptions_NotImplementedException.new = function(message,previous,pos)
  local self = _hx_new(__haxe_exceptions_NotImplementedException.prototype)
  __haxe_exceptions_NotImplementedException.super(self,message,previous,pos)
  return self
end
__haxe_exceptions_NotImplementedException.super = function(self,message,previous,pos)
  if (message == nil) then
    message = "Not implemented";
  end;
  __haxe_exceptions_PosException.super(self,message,previous,pos);
end
__haxe_exceptions_NotImplementedException.__name__ = true
__haxe_exceptions_NotImplementedException.prototype = _hx_e();

__haxe_exceptions_NotImplementedException.prototype.__class__ =  __haxe_exceptions_NotImplementedException
__haxe_exceptions_NotImplementedException.__super__ = __haxe_exceptions_PosException
setmetatable(__haxe_exceptions_NotImplementedException.prototype,{__index=__haxe_exceptions_PosException.prototype})

__haxe_io_Bytes.new = function(length,b)
  local self = _hx_new(__haxe_io_Bytes.prototype)
  __haxe_io_Bytes.super(self,length,b)
  return self
end
__haxe_io_Bytes.super = function(self,length,b)
  self.length = length;
  self.b = b;
end
__haxe_io_Bytes.__name__ = true
__haxe_io_Bytes.alloc = function(length)
  local a = Array.new();
  local _g = 0;
  local _g1 = length;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    a:push(0);
  end;
  do return __haxe_io_Bytes.new(length, a) end;
end
__haxe_io_Bytes.ofString = function(s,encoding)
  local _g = _hx_tab_array({}, 0);
  local _g1 = 0;
  local _g2 = _G.string.len(s);
  while (_g1 < _g2) do
    _g1 = _g1 + 1;
    local i = _g1 - 1;
    _g:push(_G.string.byte(s, i + 1));
  end;
  local bytes = _g;
  do return __haxe_io_Bytes.new(bytes.length, bytes) end;
end
__haxe_io_Bytes.prototype = _hx_e();
__haxe_io_Bytes.prototype.getString = function(self,pos,len,encoding)
  local tmp = encoding == nil;
  if (((pos < 0) or (len < 0)) or ((pos + len) > self.length)) then
    _G.error(__haxe_Exception.thrown(__haxe_io_Error.OutsideBounds),0);
  end;
  if ((self.b.length - pos) <= __lua_Boot.MAXSTACKSIZE) then
    local _end = Math.min(self.b.length, pos + len) - 1;
    do return _G.string.char(_hx_table.unpack(self.b, pos, _end)) end;
  else
    local tbl = ({});
    local _g = pos;
    local _g1 = pos + len;
    while (_g < _g1) do
      _g = _g + 1;
      local idx = _g - 1;
      _G.table.insert(tbl, _G.string.char(self.b[idx]));
    end;
    do return _G.table.concat(tbl, "") end;
  end;
end
__haxe_io_Bytes.prototype.toString = function(self)
  do return self:getString(0, self.length) end
end

__haxe_io_Bytes.prototype.__class__ =  __haxe_io_Bytes

__haxe_io_Input.new = {}
__haxe_io_Input.__name__ = true
__haxe_io_Input.prototype = _hx_e();
__haxe_io_Input.prototype.readByte = function(self)
  _G.error(__haxe_exceptions_NotImplementedException.new(nil, nil, _hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="haxe/io/Input.hx",lineNumber=53,className="haxe.io.Input",methodName="readByte"})),0);
end
__haxe_io_Input.prototype.readBytes = function(self,s,pos,len)
  local k = len;
  local b = s.b;
  if (((pos < 0) or (len < 0)) or ((pos + len) > s.length)) then
    _G.error(__haxe_Exception.thrown(__haxe_io_Error.OutsideBounds),0);
  end;
  local _hx_status, _hx_result = pcall(function()

      while (k > 0) do
        b[pos] = self:readByte();
        pos = pos + 1;
        k = k - 1;
      end;
    return _hx_pcall_default
  end)
  if not _hx_status and _hx_result == "_hx_pcall_break" then
  elseif not _hx_status then
    local _g = _hx_result;
    if (not __lua_Boot.__instanceof(__haxe_Exception.caught(_g):unwrap(), __haxe_io_Eof)) then
      _G.error(_g,0);
    end;
  elseif _hx_result ~= _hx_pcall_default then
    return _hx_result
  end;
  do return len - k end
end
__haxe_io_Input.prototype.read = function(self,nbytes)
  local s = __haxe_io_Bytes.alloc(nbytes);
  local p = 0;
  while (nbytes > 0) do
    local k = self:readBytes(s, p, nbytes);
    if (k == 0) then
      _G.error(__haxe_Exception.thrown(__haxe_io_Error.Blocked),0);
    end;
    p = p + k;
    nbytes = nbytes - k;
  end;
  do return s end
end

__haxe_io_Input.prototype.__class__ =  __haxe_io_Input

__haxe_io_BytesInput.new = function(b,pos,len)
  local self = _hx_new(__haxe_io_BytesInput.prototype)
  __haxe_io_BytesInput.super(self,b,pos,len)
  return self
end
__haxe_io_BytesInput.super = function(self,b,pos,len)
  if (pos == nil) then
    pos = 0;
  end;
  if (len == nil) then
    len = b.length - pos;
  end;
  if (((pos < 0) or (len < 0)) or ((pos + len) > b.length)) then
    _G.error(__haxe_Exception.thrown(__haxe_io_Error.OutsideBounds),0);
  end;
  self.b = b.b;
  self.pos = pos;
  self.len = len;
  self.totlen = len;
end
__haxe_io_BytesInput.__name__ = true
__haxe_io_BytesInput.prototype = _hx_e();
__haxe_io_BytesInput.prototype.readByte = function(self)
  if (self.len == 0) then
    _G.error(__haxe_Exception.thrown(__haxe_io_Eof.new()),0);
  end;
  self.len = self.len - 1;
  do return self.b[(function()
  local _hx_obj = self;
  local _hx_fld = 'pos';
  local _ = _hx_obj[_hx_fld];
  _hx_obj[_hx_fld] = _hx_obj[_hx_fld]  + 1;
   return _;
   end)()] end
end
__haxe_io_BytesInput.prototype.readBytes = function(self,buf,pos,len)
  if (((pos < 0) or (len < 0)) or ((pos + len) > buf.length)) then
    _G.error(__haxe_Exception.thrown(__haxe_io_Error.OutsideBounds),0);
  end;
  if ((self.len == 0) and (len > 0)) then
    _G.error(__haxe_Exception.thrown(__haxe_io_Eof.new()),0);
  end;
  if (self.len < len) then
    len = self.len;
  end;
  local b1 = self.b;
  local b2 = buf.b;
  local _g = 0;
  local _g1 = len;
  while (_g < _g1) do
    _g = _g + 1;
    local i = _g - 1;
    b2[pos + i] = b1[self.pos + i];
  end;
  local tmp = self;
  tmp.pos = tmp.pos + len;
  local tmp = self;
  tmp.len = tmp.len - len;
  do return len end
end

__haxe_io_BytesInput.prototype.__class__ =  __haxe_io_BytesInput
__haxe_io_BytesInput.__super__ = __haxe_io_Input
setmetatable(__haxe_io_BytesInput.prototype,{__index=__haxe_io_Input.prototype})
_hxClasses["haxe.io.Encoding"] = { __ename__ = true, __constructs__ = _hx_tab_array({[0]="UTF8","RawNative"},2)}
__haxe_io_Encoding = _hxClasses["haxe.io.Encoding"];
__haxe_io_Encoding.UTF8 = _hx_tab_array({[0]="UTF8",0,__enum__ = __haxe_io_Encoding},2)

__haxe_io_Encoding.RawNative = _hx_tab_array({[0]="RawNative",1,__enum__ = __haxe_io_Encoding},2)


__haxe_io_Eof.new = function()
  local self = _hx_new(__haxe_io_Eof.prototype)
  __haxe_io_Eof.super(self)
  return self
end
__haxe_io_Eof.super = function(self)
end
__haxe_io_Eof.__name__ = true
__haxe_io_Eof.prototype = _hx_e();
__haxe_io_Eof.prototype.toString = function(self)
  do return "Eof" end
end

__haxe_io_Eof.prototype.__class__ =  __haxe_io_Eof
_hxClasses["haxe.io.Error"] = { __ename__ = true, __constructs__ = _hx_tab_array({[0]="Blocked","Overflow","OutsideBounds","Custom"},4)}
__haxe_io_Error = _hxClasses["haxe.io.Error"];
__haxe_io_Error.Blocked = _hx_tab_array({[0]="Blocked",0,__enum__ = __haxe_io_Error},2)

__haxe_io_Error.Overflow = _hx_tab_array({[0]="Overflow",1,__enum__ = __haxe_io_Error},2)

__haxe_io_Error.OutsideBounds = _hx_tab_array({[0]="OutsideBounds",2,__enum__ = __haxe_io_Error},2)

__haxe_io_Error.Custom = function(e) local _x = _hx_tab_array({[0]="Custom",3,e,__enum__=__haxe_io_Error}, 3); return _x; end

__haxe_io_StringInput.new = function(s)
  local self = _hx_new(__haxe_io_StringInput.prototype)
  __haxe_io_StringInput.super(self,s)
  return self
end
__haxe_io_StringInput.super = function(self,s)
  __haxe_io_BytesInput.super(self,__haxe_io_Bytes.ofString(s));
end
__haxe_io_StringInput.__name__ = true
__haxe_io_StringInput.prototype = _hx_e();

__haxe_io_StringInput.prototype.__class__ =  __haxe_io_StringInput
__haxe_io_StringInput.__super__ = __haxe_io_BytesInput
setmetatable(__haxe_io_StringInput.prototype,{__index=__haxe_io_BytesInput.prototype})

__haxe_iterators_ArrayIterator.new = function(array)
  local self = _hx_new(__haxe_iterators_ArrayIterator.prototype)
  __haxe_iterators_ArrayIterator.super(self,array)
  return self
end
__haxe_iterators_ArrayIterator.super = function(self,array)
  self.current = 0;
  self.array = array;
end
__haxe_iterators_ArrayIterator.__name__ = true
__haxe_iterators_ArrayIterator.prototype = _hx_e();
__haxe_iterators_ArrayIterator.prototype.hasNext = function(self)
  do return self.current < self.array.length end
end
__haxe_iterators_ArrayIterator.prototype.next = function(self)
  do return self.array[(function()
  local _hx_obj = self;
  local _hx_fld = 'current';
  local _ = _hx_obj[_hx_fld];
  _hx_obj[_hx_fld] = _hx_obj[_hx_fld]  + 1;
   return _;
   end)()] end
end

__haxe_iterators_ArrayIterator.prototype.__class__ =  __haxe_iterators_ArrayIterator

__haxe_iterators_ArrayKeyValueIterator.new = function(array)
  local self = _hx_new(__haxe_iterators_ArrayKeyValueIterator.prototype)
  __haxe_iterators_ArrayKeyValueIterator.super(self,array)
  return self
end
__haxe_iterators_ArrayKeyValueIterator.super = function(self,array)
  self.array = array;
end
__haxe_iterators_ArrayKeyValueIterator.__name__ = true
__haxe_iterators_ArrayKeyValueIterator.prototype = _hx_e();

__haxe_iterators_ArrayKeyValueIterator.prototype.__class__ =  __haxe_iterators_ArrayKeyValueIterator

__lua_Boot.new = {}
__lua_Boot.__name__ = true
__lua_Boot.__instanceof = function(o,cl)
  if (cl == nil) then
    do return false end;
  end;
  local cl1 = cl;
  if (cl1) == Array then
    do return __lua_Boot.isArray(o) end;
  elseif (cl1) == Bool then
    do return _G.type(o) == "boolean" end;
  elseif (cl1) == Dynamic then
    do return o ~= nil end;
  elseif (cl1) == Float then
    do return _G.type(o) == "number" end;
  elseif (cl1) == Int then
    if (_G.type(o) == "number") then
      do return _hx_bit_clamp(o) == o end;
    else
      do return false end;
    end;
  elseif (cl1) == String then
    do return _G.type(o) == "string" end;
  elseif (cl1) == _G.table then
    do return _G.type(o) == "table" end;
  elseif (cl1) == __lua_Thread then
    do return _G.type(o) == "thread" end;
  elseif (cl1) == __lua_UserData then
    do return _G.type(o) == "userdata" end;else
  if (((o ~= nil) and (_G.type(o) == "table")) and (_G.type(cl) == "table")) then
    local tmp;
    if (__lua_Boot.__instanceof(o, Array)) then
      tmp = Array;
    else
      if (__lua_Boot.__instanceof(o, String)) then
        tmp = String;
      else
        local cl = o.__class__;
        tmp = (function()
          local _hx_1
          if (cl ~= nil) then
          _hx_1 = cl; else
          _hx_1 = nil; end
          return _hx_1
        end )();
      end;
    end;
    if (__lua_Boot.extendsOrImplements(tmp, cl)) then
      do return true end;
    end;
    if ((function()
      local _hx_2
      if (cl == Class) then
      _hx_2 = o.__name__ ~= nil; else
      _hx_2 = false; end
      return _hx_2
    end )()) then
      do return true end;
    end;
    if ((function()
      local _hx_3
      if (cl == Enum) then
      _hx_3 = o.__ename__ ~= nil; else
      _hx_3 = false; end
      return _hx_3
    end )()) then
      do return true end;
    end;
    do return o.__enum__ == cl end;
  else
    do return false end;
  end; end;
end
__lua_Boot.isArray = function(o)
  if (_G.type(o) == "table") then
    if ((o.__enum__ == nil) and (_G.getmetatable(o) ~= nil)) then
      do return _G.getmetatable(o).__index == Array.prototype end;
    else
      do return false end;
    end;
  else
    do return false end;
  end;
end
__lua_Boot.extendsOrImplements = function(cl1,cl2)
  if ((cl1 == nil) or (cl2 == nil)) then
    do return false end;
  else
    if (cl1 == cl2) then
      do return true end;
    else
      if (cl1.__interfaces__ ~= nil) then
        local intf = cl1.__interfaces__;
        local _g = 1;
        local _g1 = _hx_table.maxn(intf) + 1;
        while (_g < _g1) do
          _g = _g + 1;
          local i = _g - 1;
          if (__lua_Boot.extendsOrImplements(intf[i], cl2)) then
            do return true end;
          end;
        end;
      end;
    end;
  end;
  do return __lua_Boot.extendsOrImplements(cl1.__super__, cl2) end;
end

__lua_UserData.new = {}
__lua_UserData.__name__ = true

__lua_Thread.new = {}
__lua_Thread.__name__ = true
if _hx_bit_raw then
    _hx_bit_clamp = function(v)
    if v <= 2147483647 and v >= -2147483648 then
        if v > 0 then return _G.math.floor(v)
        else return _G.math.ceil(v)
        end
    end
    if v > 2251798999999999 then v = v*2 end;
    if (v ~= v or math.abs(v) == _G.math.huge) then return nil end
    return _hx_bit_raw.band(v, 2147483647 ) - math.abs(_hx_bit_raw.band(v, 2147483648))
    end
else
    _hx_bit_clamp = function(v)
        if v < -2147483648 then
            return -2147483648
        elseif v > 2147483647 then
            return 2147483647
        elseif v > 0 then
            return _G.math.floor(v)
        else
            return _G.math.ceil(v)
        end
    end
end;



_hx_array_mt.__index = Array.prototype

local _hx_static_init = function()

  String.__name__ = true;
  Array.__name__ = true;Node.ATTRIBUTE_NODE = 2;

  Node.CDATA_SECTION_NODE = 4;

  Node.COMMENT_NODE = 8;

  Node.DOCUMENT_NODE = 9;

  Node.DOCUMENT_TYPE_NODE = 10;

  Node.DOCUMENT_FRAGMENT_NODE = 11;

  Node.ELEMENT_NODE = 1;

  Node.ENTITY_REFERENCE_NODE = 5;

  Node.ENTITY_NODE = 6;

  Node.NOTATION_NODE = 12;

  Node.PROCESSING_INSTRUCTION_NODE = 7;

  Node.TEXT_NODE = 3;

  Exceptions.NotImplemented = "Not Implemented";

  HTMLParser.elements = _hx_tab_array({[0]="a", "abbr", "acronym", "address", "applet", "area", "article", "aside", "audio", "b", "base", "basefont", "bdi", "bdo", "bgsound", "big", "blink", "blockquote", "body", "br", "button", "canvas", "caption", "center", "cite", "code", "col", "colgroup", "command", "content", "data", "datalist", "dd", "del", "details", "dfn", "dialog", "dir", "div", "dl", "dt", "element", "em", "embed", "fieldset", "figcaption", "figure", "font", "footer", "form", "frame", "frameset", "h1", "h2", "h3", "h4", "h5", "h6", "head", "header", "hgroup", "hr", "html", "i", "iframe", "image", "img", "input", "ins", "isindex", "kbd", "keygen", "label", "legend", "li", "link", "listing", "main", "map", "mark", "marquee", "menu", "menuitem", "meta", "meter", "multicol", "nav", "nobr", "noembed", "noframes", "noscript", "object", "ol", "optgroup", "option", "output", "p", "param", "picture", "plaintext", "pre", "progress", "q", "rp", "rt", "rtc", "ruby", "s", "samp", "script", "section", "select", "shadow", "slot", "small", "source", "spacer", "span", "strike", "strong", "style", "sub", "summary", "sup", "table", "tbody", "td", "template", "textarea", "tfoot", "th", "thead", "time", "title", "tr", "track", "tt", "u", "ul", "var", "video", "wbr", "xmp"}, 143);

  HTMLParser.attr2elem = (function()
    local _hx_1

    local _g = __haxe_ds_StringMap.new();

    local value = _hx_tab_array({[0]="form", "input"}, 2);
    if (value == nil) then
      _g.h.accept = __haxe_ds_StringMap.tnull;
    else
      _g.h.accept = value;
    end;

    local value = _hx_tab_array({[0]="form"}, 1);
    if (value == nil) then
      _g.h["accept-charset"] = __haxe_ds_StringMap.tnull;
    else
      _g.h["accept-charset"] = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.accesskey = __haxe_ds_StringMap.tnull;
    else
      _g.h.accesskey = value;
    end;

    local value = _hx_tab_array({[0]="form"}, 1);
    if (value == nil) then
      _g.h.action = __haxe_ds_StringMap.tnull;
    else
      _g.h.action = value;
    end;

    local value = _hx_tab_array({[0]="applet", "caption", "col", "colgroup", "hr", "iframe", "img", "table", "tbody", "td", "tfoot", "th", "thead", "tr"}, 14);
    if (value == nil) then
      _g.h.align = __haxe_ds_StringMap.tnull;
    else
      _g.h.align = value;
    end;

    local value = _hx_tab_array({[0]="applet", "area", "img", "input"}, 4);
    if (value == nil) then
      _g.h.alt = __haxe_ds_StringMap.tnull;
    else
      _g.h.alt = value;
    end;

    local value = _hx_tab_array({[0]="script"}, 1);
    if (value == nil) then
      _g.h.async = __haxe_ds_StringMap.tnull;
    else
      _g.h.async = value;
    end;

    local value = _hx_tab_array({[0]="form", "input"}, 2);
    if (value == nil) then
      _g.h.autocomplete = __haxe_ds_StringMap.tnull;
    else
      _g.h.autocomplete = value;
    end;

    local value = _hx_tab_array({[0]="button", "input", "keygen", "select", "textarea"}, 5);
    if (value == nil) then
      _g.h.autofocus = __haxe_ds_StringMap.tnull;
    else
      _g.h.autofocus = value;
    end;

    local value = _hx_tab_array({[0]="audio", "video"}, 2);
    if (value == nil) then
      _g.h.autoplay = __haxe_ds_StringMap.tnull;
    else
      _g.h.autoplay = value;
    end;

    local value = _hx_tab_array({[0]="input"}, 1);
    if (value == nil) then
      _g.h.autosave = __haxe_ds_StringMap.tnull;
    else
      _g.h.autosave = value;
    end;

    local value = _hx_tab_array({[0]="body", "col", "colgroup", "marquee", "table", "tbody", "tfoot", "td", "th", "tr"}, 10);
    if (value == nil) then
      _g.h.bgcolor = __haxe_ds_StringMap.tnull;
    else
      _g.h.bgcolor = value;
    end;

    local value = _hx_tab_array({[0]="img", "object", "table"}, 3);
    if (value == nil) then
      _g.h.border = __haxe_ds_StringMap.tnull;
    else
      _g.h.border = value;
    end;

    local value = _hx_tab_array({[0]="audio", "video"}, 2);
    if (value == nil) then
      _g.h.buffered = __haxe_ds_StringMap.tnull;
    else
      _g.h.buffered = value;
    end;

    local value = _hx_tab_array({[0]="keygen"}, 1);
    if (value == nil) then
      _g.h.challenge = __haxe_ds_StringMap.tnull;
    else
      _g.h.challenge = value;
    end;

    local value = _hx_tab_array({[0]="meta", "script"}, 2);
    if (value == nil) then
      _g.h.charset = __haxe_ds_StringMap.tnull;
    else
      _g.h.charset = value;
    end;

    local value = _hx_tab_array({[0]="command", "input"}, 2);
    if (value == nil) then
      _g.h.checked = __haxe_ds_StringMap.tnull;
    else
      _g.h.checked = value;
    end;

    local value = _hx_tab_array({[0]="blockquote", "del", "ins", "q"}, 4);
    if (value == nil) then
      _g.h.cite = __haxe_ds_StringMap.tnull;
    else
      _g.h.cite = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.class = __haxe_ds_StringMap.tnull;
    else
      _g.h.class = value;
    end;

    local value = _hx_tab_array({[0]="applet"}, 1);
    if (value == nil) then
      _g.h.code = __haxe_ds_StringMap.tnull;
    else
      _g.h.code = value;
    end;

    local value = _hx_tab_array({[0]="applet"}, 1);
    if (value == nil) then
      _g.h.codebase = __haxe_ds_StringMap.tnull;
    else
      _g.h.codebase = value;
    end;

    local value = _hx_tab_array({[0]="basefont", "font", "hr"}, 3);
    if (value == nil) then
      _g.h.color = __haxe_ds_StringMap.tnull;
    else
      _g.h.color = value;
    end;

    local value = _hx_tab_array({[0]="textarea"}, 1);
    if (value == nil) then
      _g.h.cols = __haxe_ds_StringMap.tnull;
    else
      _g.h.cols = value;
    end;

    local value = _hx_tab_array({[0]="td", "th"}, 2);
    if (value == nil) then
      _g.h.colspan = __haxe_ds_StringMap.tnull;
    else
      _g.h.colspan = value;
    end;

    local value = _hx_tab_array({[0]="meta"}, 1);
    if (value == nil) then
      _g.h.content = __haxe_ds_StringMap.tnull;
    else
      _g.h.content = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.contenteditable = __haxe_ds_StringMap.tnull;
    else
      _g.h.contenteditable = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.contextmenu = __haxe_ds_StringMap.tnull;
    else
      _g.h.contextmenu = value;
    end;

    local value = _hx_tab_array({[0]="audio", "video"}, 2);
    if (value == nil) then
      _g.h.controls = __haxe_ds_StringMap.tnull;
    else
      _g.h.controls = value;
    end;

    local value = _hx_tab_array({[0]="area"}, 1);
    if (value == nil) then
      _g.h.coords = __haxe_ds_StringMap.tnull;
    else
      _g.h.coords = value;
    end;

    local value = _hx_tab_array({[0]="audio", "img", "link", "script", "video"}, 5);
    if (value == nil) then
      _g.h.crossorigin = __haxe_ds_StringMap.tnull;
    else
      _g.h.crossorigin = value;
    end;

    local value = _hx_tab_array({[0]="object"}, 1);
    if (value == nil) then
      _g.h.data = __haxe_ds_StringMap.tnull;
    else
      _g.h.data = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h["data-*"] = __haxe_ds_StringMap.tnull;
    else
      _g.h["data-*"] = value;
    end;

    local value = _hx_tab_array({[0]="del", "ins", "time"}, 3);
    if (value == nil) then
      _g.h.datetime = __haxe_ds_StringMap.tnull;
    else
      _g.h.datetime = value;
    end;

    local value = _hx_tab_array({[0]="track"}, 1);
    if (value == nil) then
      _g.h.default = __haxe_ds_StringMap.tnull;
    else
      _g.h.default = value;
    end;

    local value = _hx_tab_array({[0]="script"}, 1);
    if (value == nil) then
      _g.h.defer = __haxe_ds_StringMap.tnull;
    else
      _g.h.defer = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.dir = __haxe_ds_StringMap.tnull;
    else
      _g.h.dir = value;
    end;

    local value = _hx_tab_array({[0]="input", "textarea"}, 2);
    if (value == nil) then
      _g.h.dirname = __haxe_ds_StringMap.tnull;
    else
      _g.h.dirname = value;
    end;

    local value = _hx_tab_array({[0]="button", "command", "fieldset", "input", "keygen", "optgroup", "option", "select", "textarea"}, 9);
    if (value == nil) then
      _g.h.disabled = __haxe_ds_StringMap.tnull;
    else
      _g.h.disabled = value;
    end;

    local value = _hx_tab_array({[0]="a", "area"}, 2);
    if (value == nil) then
      _g.h.download = __haxe_ds_StringMap.tnull;
    else
      _g.h.download = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.draggable = __haxe_ds_StringMap.tnull;
    else
      _g.h.draggable = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.dropzone = __haxe_ds_StringMap.tnull;
    else
      _g.h.dropzone = value;
    end;

    local value = _hx_tab_array({[0]="form"}, 1);
    if (value == nil) then
      _g.h.enctype = __haxe_ds_StringMap.tnull;
    else
      _g.h.enctype = value;
    end;

    local value = _hx_tab_array({[0]="label", "output"}, 2);
    if (value == nil) then
      _g.h["for"] = __haxe_ds_StringMap.tnull;
    else
      _g.h["for"] = value;
    end;

    local value = _hx_tab_array({[0]="button", "fieldset", "input", "keygen", "label", "meter", "object", "progress", "select", "textarea"}, 10);
    if (value == nil) then
      _g.h.form = __haxe_ds_StringMap.tnull;
    else
      _g.h.form = value;
    end;

    local value = _hx_tab_array({[0]="input", "button"}, 2);
    if (value == nil) then
      _g.h.formaction = __haxe_ds_StringMap.tnull;
    else
      _g.h.formaction = value;
    end;

    local value = _hx_tab_array({[0]="td", "th"}, 2);
    if (value == nil) then
      _g.h.headers = __haxe_ds_StringMap.tnull;
    else
      _g.h.headers = value;
    end;

    local value = _hx_tab_array({[0]="canvas", "embed", "iframe", "img", "input", "object", "video"}, 7);
    if (value == nil) then
      _g.h.height = __haxe_ds_StringMap.tnull;
    else
      _g.h.height = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.hidden = __haxe_ds_StringMap.tnull;
    else
      _g.h.hidden = value;
    end;

    local value = _hx_tab_array({[0]="meter"}, 1);
    if (value == nil) then
      _g.h.high = __haxe_ds_StringMap.tnull;
    else
      _g.h.high = value;
    end;

    local value = _hx_tab_array({[0]="a", "area", "base", "link"}, 4);
    if (value == nil) then
      _g.h.href = __haxe_ds_StringMap.tnull;
    else
      _g.h.href = value;
    end;

    local value = _hx_tab_array({[0]="a", "area", "link"}, 3);
    if (value == nil) then
      _g.h.hreflang = __haxe_ds_StringMap.tnull;
    else
      _g.h.hreflang = value;
    end;

    local value = _hx_tab_array({[0]="meta"}, 1);
    if (value == nil) then
      _g.h["http-equiv"] = __haxe_ds_StringMap.tnull;
    else
      _g.h["http-equiv"] = value;
    end;

    local value = _hx_tab_array({[0]="command"}, 1);
    if (value == nil) then
      _g.h.icon = __haxe_ds_StringMap.tnull;
    else
      _g.h.icon = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.id = __haxe_ds_StringMap.tnull;
    else
      _g.h.id = value;
    end;

    local value = _hx_tab_array({[0]="link", "script"}, 2);
    if (value == nil) then
      _g.h.integrity = __haxe_ds_StringMap.tnull;
    else
      _g.h.integrity = value;
    end;

    local value = _hx_tab_array({[0]="img"}, 1);
    if (value == nil) then
      _g.h.ismap = __haxe_ds_StringMap.tnull;
    else
      _g.h.ismap = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.itemprop = __haxe_ds_StringMap.tnull;
    else
      _g.h.itemprop = value;
    end;

    local value = _hx_tab_array({[0]="keygen"}, 1);
    if (value == nil) then
      _g.h.keytype = __haxe_ds_StringMap.tnull;
    else
      _g.h.keytype = value;
    end;

    local value = _hx_tab_array({[0]="track"}, 1);
    if (value == nil) then
      _g.h.kind = __haxe_ds_StringMap.tnull;
    else
      _g.h.kind = value;
    end;

    local value = _hx_tab_array({[0]="track"}, 1);
    if (value == nil) then
      _g.h.label = __haxe_ds_StringMap.tnull;
    else
      _g.h.label = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.lang = __haxe_ds_StringMap.tnull;
    else
      _g.h.lang = value;
    end;

    local value = _hx_tab_array({[0]="script"}, 1);
    if (value == nil) then
      _g.h.language = __haxe_ds_StringMap.tnull;
    else
      _g.h.language = value;
    end;

    local value = _hx_tab_array({[0]="input"}, 1);
    if (value == nil) then
      _g.h.list = __haxe_ds_StringMap.tnull;
    else
      _g.h.list = value;
    end;

    local value = _hx_tab_array({[0]="audio", "bgsound", "marquee", "video"}, 4);
    if (value == nil) then
      _g.h.loop = __haxe_ds_StringMap.tnull;
    else
      _g.h.loop = value;
    end;

    local value = _hx_tab_array({[0]="meter"}, 1);
    if (value == nil) then
      _g.h.low = __haxe_ds_StringMap.tnull;
    else
      _g.h.low = value;
    end;

    local value = _hx_tab_array({[0]="html"}, 1);
    if (value == nil) then
      _g.h.manifest = __haxe_ds_StringMap.tnull;
    else
      _g.h.manifest = value;
    end;

    local value = _hx_tab_array({[0]="input", "meter", "progress"}, 3);
    if (value == nil) then
      _g.h.max = __haxe_ds_StringMap.tnull;
    else
      _g.h.max = value;
    end;

    local value = _hx_tab_array({[0]="input", "textarea"}, 2);
    if (value == nil) then
      _g.h.maxlength = __haxe_ds_StringMap.tnull;
    else
      _g.h.maxlength = value;
    end;

    local value = _hx_tab_array({[0]="input", "textarea"}, 2);
    if (value == nil) then
      _g.h.minlength = __haxe_ds_StringMap.tnull;
    else
      _g.h.minlength = value;
    end;

    local value = _hx_tab_array({[0]="a", "area", "link", "source", "style"}, 5);
    if (value == nil) then
      _g.h.media = __haxe_ds_StringMap.tnull;
    else
      _g.h.media = value;
    end;

    local value = _hx_tab_array({[0]="form"}, 1);
    if (value == nil) then
      _g.h.method = __haxe_ds_StringMap.tnull;
    else
      _g.h.method = value;
    end;

    local value = _hx_tab_array({[0]="input", "meter"}, 2);
    if (value == nil) then
      _g.h.min = __haxe_ds_StringMap.tnull;
    else
      _g.h.min = value;
    end;

    local value = _hx_tab_array({[0]="input", "select"}, 2);
    if (value == nil) then
      _g.h.multiple = __haxe_ds_StringMap.tnull;
    else
      _g.h.multiple = value;
    end;

    local value = _hx_tab_array({[0]="video"}, 1);
    if (value == nil) then
      _g.h.muted = __haxe_ds_StringMap.tnull;
    else
      _g.h.muted = value;
    end;

    local value = _hx_tab_array({[0]="button", "form", "fieldset", "iframe", "input", "keygen", "object", "output", "select", "textarea", "map", "meta", "param"}, 13);
    if (value == nil) then
      _g.h.name = __haxe_ds_StringMap.tnull;
    else
      _g.h.name = value;
    end;

    local value = _hx_tab_array({[0]="form"}, 1);
    if (value == nil) then
      _g.h.novalidate = __haxe_ds_StringMap.tnull;
    else
      _g.h.novalidate = value;
    end;

    local value = _hx_tab_array({[0]="details"}, 1);
    if (value == nil) then
      _g.h.open = __haxe_ds_StringMap.tnull;
    else
      _g.h.open = value;
    end;

    local value = _hx_tab_array({[0]="meter"}, 1);
    if (value == nil) then
      _g.h.optimum = __haxe_ds_StringMap.tnull;
    else
      _g.h.optimum = value;
    end;

    local value = _hx_tab_array({[0]="input"}, 1);
    if (value == nil) then
      _g.h.pattern = __haxe_ds_StringMap.tnull;
    else
      _g.h.pattern = value;
    end;

    local value = _hx_tab_array({[0]="a", "area"}, 2);
    if (value == nil) then
      _g.h.ping = __haxe_ds_StringMap.tnull;
    else
      _g.h.ping = value;
    end;

    local value = _hx_tab_array({[0]="input", "textarea"}, 2);
    if (value == nil) then
      _g.h.placeholder = __haxe_ds_StringMap.tnull;
    else
      _g.h.placeholder = value;
    end;

    local value = _hx_tab_array({[0]="video"}, 1);
    if (value == nil) then
      _g.h.poster = __haxe_ds_StringMap.tnull;
    else
      _g.h.poster = value;
    end;

    local value = _hx_tab_array({[0]="audio", "video"}, 2);
    if (value == nil) then
      _g.h.preload = __haxe_ds_StringMap.tnull;
    else
      _g.h.preload = value;
    end;

    local value = _hx_tab_array({[0]="command"}, 1);
    if (value == nil) then
      _g.h.radiogroup = __haxe_ds_StringMap.tnull;
    else
      _g.h.radiogroup = value;
    end;

    local value = _hx_tab_array({[0]="input", "textarea"}, 2);
    if (value == nil) then
      _g.h.readonly = __haxe_ds_StringMap.tnull;
    else
      _g.h.readonly = value;
    end;

    local value = _hx_tab_array({[0]="a", "area", "link"}, 3);
    if (value == nil) then
      _g.h.rel = __haxe_ds_StringMap.tnull;
    else
      _g.h.rel = value;
    end;

    local value = _hx_tab_array({[0]="input", "select", "textarea"}, 3);
    if (value == nil) then
      _g.h.required = __haxe_ds_StringMap.tnull;
    else
      _g.h.required = value;
    end;

    local value = _hx_tab_array({[0]="ol"}, 1);
    if (value == nil) then
      _g.h.reversed = __haxe_ds_StringMap.tnull;
    else
      _g.h.reversed = value;
    end;

    local value = _hx_tab_array({[0]="textarea"}, 1);
    if (value == nil) then
      _g.h.rows = __haxe_ds_StringMap.tnull;
    else
      _g.h.rows = value;
    end;

    local value = _hx_tab_array({[0]="td", "th"}, 2);
    if (value == nil) then
      _g.h.rowspan = __haxe_ds_StringMap.tnull;
    else
      _g.h.rowspan = value;
    end;

    local value = _hx_tab_array({[0]="iframe"}, 1);
    if (value == nil) then
      _g.h.sandbox = __haxe_ds_StringMap.tnull;
    else
      _g.h.sandbox = value;
    end;

    local value = _hx_tab_array({[0]="th"}, 1);
    if (value == nil) then
      _g.h.scope = __haxe_ds_StringMap.tnull;
    else
      _g.h.scope = value;
    end;

    local value = _hx_tab_array({[0]="style"}, 1);
    if (value == nil) then
      _g.h.scoped = __haxe_ds_StringMap.tnull;
    else
      _g.h.scoped = value;
    end;

    local value = _hx_tab_array({[0]="iframe"}, 1);
    if (value == nil) then
      _g.h.seamless = __haxe_ds_StringMap.tnull;
    else
      _g.h.seamless = value;
    end;

    local value = _hx_tab_array({[0]="option"}, 1);
    if (value == nil) then
      _g.h.selected = __haxe_ds_StringMap.tnull;
    else
      _g.h.selected = value;
    end;

    local value = _hx_tab_array({[0]="a", "area"}, 2);
    if (value == nil) then
      _g.h.shape = __haxe_ds_StringMap.tnull;
    else
      _g.h.shape = value;
    end;

    local value = _hx_tab_array({[0]="input", "select"}, 2);
    if (value == nil) then
      _g.h.size = __haxe_ds_StringMap.tnull;
    else
      _g.h.size = value;
    end;

    local value = _hx_tab_array({[0]="link", "img", "source"}, 3);
    if (value == nil) then
      _g.h.sizes = __haxe_ds_StringMap.tnull;
    else
      _g.h.sizes = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.slot = __haxe_ds_StringMap.tnull;
    else
      _g.h.slot = value;
    end;

    local value = _hx_tab_array({[0]="col", "colgroup"}, 2);
    if (value == nil) then
      _g.h.span = __haxe_ds_StringMap.tnull;
    else
      _g.h.span = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.spellcheck = __haxe_ds_StringMap.tnull;
    else
      _g.h.spellcheck = value;
    end;

    local value = _hx_tab_array({[0]="audio", "embed", "iframe", "img", "input", "script", "source", "track", "video"}, 9);
    if (value == nil) then
      _g.h.src = __haxe_ds_StringMap.tnull;
    else
      _g.h.src = value;
    end;

    local value = _hx_tab_array({[0]="iframe"}, 1);
    if (value == nil) then
      _g.h.srcdoc = __haxe_ds_StringMap.tnull;
    else
      _g.h.srcdoc = value;
    end;

    local value = _hx_tab_array({[0]="track"}, 1);
    if (value == nil) then
      _g.h.srclang = __haxe_ds_StringMap.tnull;
    else
      _g.h.srclang = value;
    end;

    local value = _hx_tab_array({[0]="img"}, 1);
    if (value == nil) then
      _g.h.srcset = __haxe_ds_StringMap.tnull;
    else
      _g.h.srcset = value;
    end;

    local value = _hx_tab_array({[0]="ol"}, 1);
    if (value == nil) then
      _g.h.start = __haxe_ds_StringMap.tnull;
    else
      _g.h.start = value;
    end;

    local value = _hx_tab_array({[0]="input"}, 1);
    if (value == nil) then
      _g.h.step = __haxe_ds_StringMap.tnull;
    else
      _g.h.step = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.style = __haxe_ds_StringMap.tnull;
    else
      _g.h.style = value;
    end;

    local value = _hx_tab_array({[0]="table"}, 1);
    if (value == nil) then
      _g.h.summary = __haxe_ds_StringMap.tnull;
    else
      _g.h.summary = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.tabindex = __haxe_ds_StringMap.tnull;
    else
      _g.h.tabindex = value;
    end;

    local value = _hx_tab_array({[0]="a", "area", "base", "form"}, 4);
    if (value == nil) then
      _g.h.target = __haxe_ds_StringMap.tnull;
    else
      _g.h.target = value;
    end;

    local value = _hx_tab_array({[0]="*"}, 1);
    if (value == nil) then
      _g.h.title = __haxe_ds_StringMap.tnull;
    else
      _g.h.title = value;
    end;

    local value = _hx_tab_array({[0]="button", "input", "command", "embed", "object", "script", "source", "style", "menu"}, 9);
    if (value == nil) then
      _g.h.type = __haxe_ds_StringMap.tnull;
    else
      _g.h.type = value;
    end;

    local value = _hx_tab_array({[0]="img", "input", "object"}, 3);
    if (value == nil) then
      _g.h.usemap = __haxe_ds_StringMap.tnull;
    else
      _g.h.usemap = value;
    end;

    local value = _hx_tab_array({[0]="button", "option", "input", "li", "meter", "progress", "param"}, 7);
    if (value == nil) then
      _g.h.value = __haxe_ds_StringMap.tnull;
    else
      _g.h.value = value;
    end;

    local value = _hx_tab_array({[0]="canvas", "embed", "iframe", "img", "input", "object", "video"}, 7);
    if (value == nil) then
      _g.h.width = __haxe_ds_StringMap.tnull;
    else
      _g.h.width = value;
    end;

    local value = _hx_tab_array({[0]="textarea"}, 1);
    if (value == nil) then
      _g.h.wrap = __haxe_ds_StringMap.tnull;
    else
      _g.h.wrap = value;
    end;

    _hx_1 = _g;
    return _hx_1
  end )();

  __haxe_ds_StringMap.tnull = ({});

  __lua_Boot.MAXSTACKSIZE = 1000;


end

_hx_table = {}
_hx_table.pack = _G.table.pack or function(...)
    return {...}
end
_hx_table.unpack = _G.table.unpack or _G.unpack
_hx_table.maxn = _G.table.maxn or function(t)
  local maxn=0;
  for i in pairs(t) do
    maxn=type(i)=='number'and i>maxn and i or maxn
  end
  return maxn
end;

_hx_static_init();
return _hx_exports
