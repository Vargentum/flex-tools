(function() {
  var Example, ExampleForFill,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Example = (function() {
    function Example($el, type) {
      this.autoUpdate = bind(this.autoUpdate, this);
      this.el = $el;
      this.type = type;
      this.select = $el.find('.example__select');
      this.list = $el.find('.example__list');
      this.autoUpdate();
    }

    Example.prototype.autoUpdate = function() {
      var currentState;
      currentState = this.select.val();
      return this.select.off('change').on('change', (function(_this) {
        return function() {
          _this.list.removeClass('f-' + _this.type + '--' + currentState);
          _this.list.addClass('f-' + _this.type + '--' + _this.select.val());
          return _this.autoUpdate();
        };
      })(this));
    };

    return Example;

  })();

  new Example($('.example--align'), 'align');

  new Example($('.example--dir'), 'dir');

  new Example($('.example--gap'), 'gap');

  ExampleForFill = (function() {
    function ExampleForFill() {
      this.init = bind(this.init, this);
      this.updSidebarWidth = bind(this.updSidebarWidth, this);
      this.setSidebarWidth = bind(this.setSidebarWidth, this);
      this.el = $('.example--fill');
      this.range = this.el.find('.example__input');
      this.sidebar = this.el.find('.example__unit--sidebar');
      this.init();
    }

    ExampleForFill.prototype.setSidebarWidth = function() {
      return this.sidebar.css({
        width: this.range.val(),
        height: this.range.val() / 5
      });
    };

    ExampleForFill.prototype.updSidebarWidth = function() {
      return this.range.change((function(_this) {
        return function() {
          return _this.setSidebarWidth();
        };
      })(this));
    };

    ExampleForFill.prototype.init = function() {
      this.setSidebarWidth();
      return this.updSidebarWidth();
    };

    return ExampleForFill;

  })();

  new ExampleForFill();

}).call(this);
